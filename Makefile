# =============================
# Flutter Project Makefile
# =============================
# This Makefile acts as a developer productivity layer + CI/CD helper.
# It standardizes commands for build, test, release, and GitHub workflows.

# Extract app name from pubspec.yaml
APP_NAME := $(shell grep '^name:' pubspec.yaml | awk '{print $$2}')

# Extract full version (e.g., 1.0.0+1)
VERSION_BUILD := $(shell grep '^version:' pubspec.yaml | awk '{print $$2}')

# Extract semantic version (e.g., 1.0.0)
VERSION := $(shell echo $(VERSION_BUILD) | cut -d'+' -f1)

# Extract build number (e.g., 1)
BUILD := $(shell echo $(VERSION_BUILD) | cut -d'+' -f2)

# Directory for obfuscation debug symbols
DEBUG_INFO := ./debug-info


# =============================
# --------- SETUP -------------
# =============================

# Runs Flutter doctor and installs dependencies
# Use this when setting up the project for the first time
.PHONY: setup
setup:
	@flutter doctor
	@flutter pub get

# Full bootstrap: ensures GitHub auth + environment setup
# Recommended for new developers onboarding
.PHONY: bootstrap
bootstrap: gh-check setup
	@echo "✅ Project ready"


# =============================
# --------- CLEAN -------------
# =============================

# Standard Flutter clean
# Removes build/ and temporary artifacts
.PHONY: clean
clean:
	@flutter clean

# Deep clean: removes all caches including Pods, Gradle, and Dart cache
# Useful when facing weird build or dependency issues
.PHONY: deep-clean
deep-clean:
	@flutter clean
	@rm -rf pubspec.lock .dart_tool build ios/Pods ios/Podfile.lock
	@cd android && ./gradlew clean && cd ..

# Reset project: deep clean + fresh dependency install
.PHONY: reset
reset: deep-clean setup


# =============================
# --------- DEVELOPMENT -------
# =============================

# Run app in debug mode
.PHONY: run
run:
	@flutter run

# Run app in release mode (closer to production behavior)
.PHONY: run-release
run-release:
	@flutter run --release

# List all connected devices/emulators
.PHONY: devices
devices:
	@flutter devices

# Detailed environment diagnostics
.PHONY: doctor
doctor:
	@flutter doctor -v


# =============================
# --------- CODE QUALITY ------
# =============================

# Automatically fix lint issues
.PHONY: fix
fix:
	@dart fix --apply

# Static analysis for code issues
.PHONY: analyze
analyze:
	@dart analyze lib test

# Format code (auto-fix style)
.PHONY: format
format:
	@dart format lib test

# Check formatting without modifying files (CI-friendly)
.PHONY: format-check
format-check:
	@dart format --set-exit-if-changed lib test

# Run all quality checks together
.PHONY: prepare
prepare: fix format analyze


# =============================
# --------- TESTING -----------
# =============================

# Run all unit/widget tests
.PHONY: test
test:
	@flutter test

# Generate test coverage report
# Requires `lcov` installed for HTML output
.PHONY: coverage
coverage:
	@flutter test --coverage
	@genhtml coverage/lcov.info -o coverage/html || echo "Install lcov"


# =============================
# --------- BUILD RUNNER ------
# =============================

# Run code generation once (Freezed, JSON, etc.)
.PHONY: build
build:
	@dart run build_runner build --delete-conflicting-outputs

# Watch mode for continuous code generation
.PHONY: watch
watch:
	@dart run build_runner watch --delete-conflicting-outputs


# =============================
# --------- BUILDS ------------
# =============================

# Build release APK with obfuscation
.PHONY: apk
apk:
	@flutter build apk --release --obfuscate --split-debug-info=$(DEBUG_INFO)

# Build release AAB (Play Store requirement)
.PHONY: aab
aab:
	@flutter build appbundle --release --obfuscate --split-debug-info=$(DEBUG_INFO)


# =============================
# --------- VERSIONING --------
# =============================
# Automatically bumps version in pubspec.yaml
# Supports: patch, minor, major increments

define bump_version
	current=$$(grep '^version:' pubspec.yaml | awk '{print $$2}'); \
	version=$$(echo $$current | cut -d+ -f1); \
	build=$$(echo $$current | cut -d+ -f2); \
	major=$$(echo $$version | cut -d. -f1); \
	minor=$$(echo $$version | cut -d. -f2); \
	patch=$$(echo $$version | cut -d. -f3); \
	if [ "$(1)" = "major" ]; then major=$$((major+1)); minor=0; patch=0; fi; \
	if [ "$(1)" = "minor" ]; then minor=$$((minor+1)); patch=0; fi; \
	if [ "$(1)" = "patch" ]; then patch=$$((patch+1)); fi; \
	build=$$((build+1)); \
	new_version="$$major.$$minor.$$patch+$$build"; \
	sed -i.bak "s/^version:.*/version: $$new_version/" pubspec.yaml; \
	rm pubspec.yaml.bak; \
	echo "🚀 Version bumped to $$new_version"
endef

# Increment major version (breaking changes)
.PHONY: bump-major
bump-major:
	@$(call bump_version,major)

# Increment minor version (new features)
.PHONY: bump-minor
bump-minor:
	@$(call bump_version,minor)

# Increment patch version (bug fixes)
.PHONY: bump-patch
bump-patch:
	@$(call bump_version,patch)


# =============================
# --------- GIT OPERATIONS ----
# =============================

# Show git status
.PHONY: status
status:
	@git status

# Commit all changes with message
# Usage: make commit m="your message"
.PHONY: commit
commit:
	@git add .
	@git commit -m "$(m)" || echo "No changes"

# Push code to main branch
# Automatically checks GitHub authentication
.PHONY: push
push: gh-check
	@git push origin main

# Create and push git tag based on version
# Used to trigger CD pipeline
.PHONY: tag
tag:
	@tag="v$(VERSION)"; \
	git tag $$tag; \
	git push origin $$tag; \
	echo "🏷️ Tagged $$tag"


# =============================
# --------- RELEASE FLOW ------
# =============================

# Full release pipeline:
# 1. Code quality checks
# 2. Run tests
# 3. Bump patch version
# 4. Commit changes
# 5. Push to main
# 6. Tag release (triggers CI/CD)
.PHONY: release
release: prepare test bump-patch commit push tag
	@echo "🚀 Release triggered (CI/CD will handle builds)"


# =============================
# --------- CI/CD -------------
# =============================

# Run CI checks locally (same as pipeline)
.PHONY: ci
ci:
	@flutter pub get
	@dart analyze
	@flutter test

# Manually trigger CD workflow via GitHub CLI
.PHONY: cd
cd: gh-check
	@gh workflow run "Flutter CD"

# List GitHub Actions runs
.PHONY: actions
actions:
	@gh run list

# View logs of latest run
.PHONY: logs
logs:
	@gh run view --log

# Continuously watch workflow status (refresh every 5s)
.PHONY: watch-actions
watch-actions:
	@watch -n 5 gh run list


# =============================
# --------- GITHUB AUTH -------
# =============================

# Ensures GitHub CLI is installed and authenticated
# If not authenticated, triggers login flow
.PHONY: gh-check
gh-check:
	@if ! command -v gh >/dev/null 2>&1; then \
		echo "❌ Install GitHub CLI: https://cli.github.com/"; \
		exit 1; \
	fi
	@if ! gh auth status >/dev/null 2>&1; then \
		echo "🔐 Logging into GitHub..."; \
		gh auth login; \
	else \
		echo "✅ GitHub authenticated"; \
	fi


# =============================
# --------- UTILITIES ---------
# =============================

# Print environment details (app name, version, build)
.PHONY: env
env:
	@echo "App: $(APP_NAME)"
	@echo "Version: $(VERSION)"
	@echo "Build: $(BUILD)"

# Show project structure (fallback if tree not installed)
.PHONY: tree
tree:
	@tree -L 3 || ls -R | head -100