
import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("env")

    productFlavors {
        create("dev") {
            dimension = "env"
            applicationId = "com.zingworks.bloc_clean_arch.dev"
            resValue(type = "string", name = "app_name", value = "Zingworks Dev")
        }
        create("prod") {
            dimension = "env"
            applicationId = "com.zingworks.bloc_clean_arch"
            resValue(type = "string", name = "app_name", value = "Zingworks")
        }
    }
}