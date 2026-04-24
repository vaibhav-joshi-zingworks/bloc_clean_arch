# =============================
# Flutter Project Makefile
# =============================

# --------- GENERAL TASKS ---------
.PHONY: clean
clean:
	@flutter clean

.PHONY: get
get:
	@flutter clean && flutter pub get  && cd android && ./gradlew clean && cd ..

.PHONY: run
run:
	@flutter run

.PHONY: fix
fix:
	@dart fix --apply

.PHONY: check-fix
check-fix:
	@dart fix --dry-run

.PHONY: analyze
analyze:
	@dart analyze lib test

.PHONY: format
format:
	@dart format --set-exit-if-changed lib test

.PHONY: prepare
prepare: fix format analyze

# --------- ASSET GENERATOR ---------
.PHONY: build-asset
build-asset:
	@flutter pub run build_runner build --delete-conflicting-outputs


# --------- CODE GENERATION ---------
.PHONY: build
build:
	@dart run build_runner build --delete-conflicting-outputs

.PHONY: watch
watch:
	@dart run build_runner watch --delete-conflicting-outputs

# --------- WEB TASKS ---------
.PHONY: run-web
run-web:
	@flutter run -d chrome --web-renderer html

.PHONY: build-web
build-web:
	@flutter build web --release --web-renderer html

# --------- ANDROID BUILDS ---------
.PHONY: apk-rel-obf
apk-rel-obf:
	@flutter build apk --release --obfuscate --split-debug-info=./debug-info

.PHONY: bundle-rel-obf
bundle-rel-obf:
	@flutter build appbundle --release --obfuscate --split-debug-info=./debug-info

# --------- FLAVOR BUILDS ---------
.PHONY: apk-dev
apk-dev:
	@flutter build apk --flavor development -t lib/main_development.dart --release --obfuscate --split-debug-info=./debug-info

.PHONY: apk-beta
apk-beta:
	@flutter build apk --flavor beta -t lib/main_beta.dart --release --obfuscate --split-debug-info=./debug-info

.PHONY: apk-prod
apk-prod:
	@flutter build apk --flavor production -t lib/main_production.dart --release --obfuscate --split-debug-info=./debug-info

.PHONY: aab-dev
aab-dev:
	@flutter build appbundle --flavor development -t lib/main_development.dart --release --obfuscate --split-debug-info=./debug-info

.PHONY: aab-beta
aab-beta:
	@flutter build appbundle --flavor beta -t lib/main_beta.dart --release --obfuscate --split-debug-info=./debug-info

.PHONY: aab-prod
aab-prod:
	@flutter build appbundle --flavor production -t lib/main_production.dart --release --obfuscate --split-debug-info=./debug-info


# --------- SPLASH SCREEN ---------
.PHONY: splash
splash:
	@dart run flutter_native_splash:create

# --------- LOCALIZATION ---------
.PHONY: gen-l10n
gen-l10n:
	@flutter gen-l10n

.PHONY: arb
arb:
	@if [ -z "$(lang)" ]; then \
		echo "❌ Please provide a language code: make arb lang=hi"; \
	elif [ -f "lib/l10n/app_$(lang).arb" ]; then \
		echo "⚠️  File lib/l10n/app_$(lang).arb already exists. Skipping creation."; \
	else \
		mkdir -p lib/l10n; \
		echo "{}" > lib/l10n/app_$(lang).arb; \
		echo "✅ Created: lib/l10n/app_$(lang).arb"; \
	fi

# --------- FEATURE CREATION ---------
# --------- Example Usage = $ make feat name=$name ---------
.PHONY: feat
feat:
	@if [ -z "$(name)" ]; then \
		echo "❌ Please provide a feature name: make create-feature name=home"; \
	elif [ -d "lib/features/$(name)" ]; then \
		echo "⚠️  Feature '$(name)' already exists. Skipping creation."; \
	else \
		mkdir -p lib/features/$(name)/view; \
		mkdir -p lib/features/$(name)/view_model; \
		mkdir -p lib/features/$(name)/repository; \
		mkdir -p lib/features/$(name)/models; \
		\
		touch lib/features/$(name)/view/$(name)_view.dart; \
		touch lib/features/$(name)/view_model/$(name)_view_model.dart; \
		touch lib/features/$(name)/repository/$(name)_repository.dart; \
		touch lib/features/$(name)/repository/$(name)_repository_impl.dart; \
		touch lib/features/$(name)/models/$(name)_response_model.dart; \
  		\
		echo "✅ Feature '$(name)' created with folders and initial dart files:"; \
		echo "   view/$(name)_view.dart"; \
		echo "   view_model/$(name)_view_model.dart"; \
		echo "   repository/$(name)_repository.dart"; \
		echo "   repository/$(name)_repository_impl.dart"; \
		echo "   model/$(name)_response_model.dart"; \
  	fi

# --------- RELEASE ARTIFACTS ---------
.PHONY: release-artifacts
release-artifacts:
	@appname=$$(grep '^name:' pubspec.yaml | awk '{print $$2}'); \
	flavor=$${flavor:-production}; \
	version_build=$$(grep '^version:' pubspec.yaml | awk '{print $$2}'); \
	version=$$(echo $$version_build | cut -d'+' -f1); \
	buildnumber=$$(echo $$version_build | cut -d'+' -f2); \
	dt=$$(date +%d-%m-%Y-%H-%M-%S); \
	if [ "$$flavor" = "production" ]; then short_flavor=prod; flavor_dir=productionRelease; \
	elif [ "$$flavor" = "development" ]; then short_flavor=dev; flavor_dir=developmentRelease; \
	elif [ "$$flavor" = "beta" ]; then short_flavor=beta; flavor_dir=betaRelease; \
	else short_flavor=$$flavor; flavor_dir=$${flavor}Release; fi; \
	release_dir=release-artifacts; \
	artifact_name=$${appname}-$$flavor-$$dt-$$version+$$buildnumber; \
	mkdir -p $$release_dir/$$artifact_name; \
	echo "Building AAB for flavor: $$flavor"; \
	$(MAKE) aab-$$short_flavor; \
	echo "Building APK for flavor: $$flavor"; \
	$(MAKE) apk-$$short_flavor; \
	apk_path=build/app/outputs/flutter-apk/app-$$flavor-release.apk; \
	aab_path=build/app/outputs/bundle/$$flavor_dir/app-$$flavor-release.aab; \
	new_apk_name=$${artifact_name}.apk; \
	new_aab_name=$${artifact_name}.aab; \
	if [ -f "$$apk_path" ]; then \
	  cp "$$apk_path" "$$release_dir/$$artifact_name/$$new_apk_name"; \
	  echo "✅ APK copied to $$release_dir/$$artifact_name/$$new_apk_name"; \
	else \
	  echo "❌ APK not found at $$apk_path"; \
	fi; \
	if [ -f "$$aab_path" ]; then \
	  cp "$$aab_path" "$$release_dir/$$artifact_name/$$new_aab_name"; \
	  echo "✅ AAB copied to $$release_dir/$$artifact_name/$$new_aab_name"; \
	else \
	  echo "❌ AAB not found at $$aab_path"; \
	fi; \
	echo "Release artifacts are available at: $$(pwd)/$$release_dir/$$artifact_name"
