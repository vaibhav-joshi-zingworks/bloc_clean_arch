import com.android.build.gradle.AppExtension
import groovy.json.JsonSlurper
import org.gradle.api.Project

private fun Project.applyBuildConfigFromDartDefineJson(
    relativePath: String,
    flavor: com.android.build.api.dsl.ApplicationProductFlavor,
) {
    val jsonFile = rootProject.file(relativePath)
    if (!jsonFile.exists()) {
        logger.lifecycle("Android env: missing ${jsonFile.path} — BuildConfig env fields will be empty for this flavor.")
        return
    }
    @Suppress("UNCHECKED_CAST")
    val map = JsonSlurper().parse(jsonFile) as Map<String, *>
    val keys = listOf("FLAVOR", "HOST", "BASE_URL", "IMAGE_BASE_URL", "APP_ENCRYPTION_KEY")
    for (key in keys) {
        val raw = map[key]?.toString() ?: ""
        val escaped = raw.replace("\\", "\\\\").replace("\"", "\\\"")
        val field = "ENV_$key"
        flavor.buildConfigField("String", field, "\"$escaped\"")
    }
}

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("env")

    productFlavors {
        create("dev") {
            dimension = "env"
            applicationId = "com.zingworks.bloc_clean_arch.dev"
            resValue(type = "string", name = "app_name", value = "Zingworks Dev")
            project.applyBuildConfigFromDartDefineJson("../config/dev.json", this)
        }
        create("prod") {
            dimension = "env"
            applicationId = "com.zingworks.bloc_clean_arch"
            resValue(type = "string", name = "app_name", value = "Zingworks")
            project.applyBuildConfigFromDartDefineJson("../config/prod.json", this)
        }
    }
}