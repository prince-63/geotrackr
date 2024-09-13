# Flutter-specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.** { *; }

# Keep classes used by reflection
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

# Keep attributes used by reflection
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <fields>;
}

# Keep native method names
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep all annotations
-keepattributes *Annotation*

# Keep all enums
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Keep all Parcelable implementations
-keepclassmembers class * implements android.os.Parcelable {
    static ** CREATOR;
}

# Keep all classes extending android.app.Activity
-keep class * extends android.app.Activity

# Keep all classes extending android.app.Service
-keep class * extends android.app.Service

# Keep all classes extending android.content.BroadcastReceiver
-keep class * extends android.content.BroadcastReceiver

# Keep all classes extending android.content.ContentProvider
-keep class * extends android.content.ContentProvider

# Keep all classes extending android.app.Application
-keep class * extends android.app.Application

# Keep all classes extending android.app.Fragment
-keep class * extends android.app.Fragment

# Keep all classes extending android.support.v4.app.Fragment
-keep class * extends android.support.v4.app.Fragment

# Keep all classes extending android.support.v7.app.AppCompatActivity
-keep class * extends android.support.v7.app.AppCompatActivity

# Keep all classes extending android.support.v7.widget.RecyclerView
-keep class * extends android.support.v7.widget.RecyclerView

# Keep all classes extending android.support.v7.widget.RecyclerView$ViewHolder
-keep class * extends android.support.v7.widget.RecyclerView$ViewHolder

# Keep all classes extending android.support.v7.widget.RecyclerView$Adapter
-keep class * extends android.support.v7.widget.RecyclerView$Adapter

# Keep all classes extending android.support.v7.widget.RecyclerView$LayoutManager
-keep class * extends android.support.v7.widget.RecyclerView$LayoutManager

# Keep all classes extending android.support.v7.widget.RecyclerView$ItemAnimator
-keep class * extends android.support.v7.widget.RecyclerView$ItemAnimator

# Keep all classes extending android.support.v7.widget.RecyclerView$ItemDecoration
-keep class * extends android.support.v7.widget.RecyclerView$ItemDecoration

# Keep all classes extending android.support.v7.widget.RecyclerView$OnScrollListener
-keep class * extends android.support.v7.widget.RecyclerView$OnScrollListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnItemTouchListener
-keep class * extends android.support.v7.widget.RecyclerView$OnItemTouchListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener
-keep class * extends android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnItemTouchListener
-keep class * extends android.support.v7.widget.RecyclerView$OnItemTouchListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener
-keep class * extends android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnItemTouchListener
-keep class * extends android.support.v7.widget.RecyclerView$OnItemTouchListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener
-keep class * extends android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnItemTouchListener
-keep class * extends android.support.v7.widget.RecyclerView$OnItemTouchListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener
-keep class * extends android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnItemTouchListener
-keep class * extends android.support.v7.widget.RecyclerView$OnItemTouchListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener
-keep class * extends android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnItemTouchListener
-keep class * extends android.support.v7.widget.RecyclerView$OnItemTouchListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener
-keep class * extends android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnItemTouchListener
-keep class * extends android.support.v7.widget.RecyclerView$OnItemTouchListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener
-keep class * extends android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnItemTouchListener
-keep class * extends android.support.v7.widget.RecyclerView$OnItemTouchListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener
-keep class * extends android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnItemTouchListener
-keep class * extends android.support.v7.widget.RecyclerView$OnItemTouchListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener
-keep class * extends android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnItemTouchListener
-keep class * extends android.support.v7.widget.RecyclerView$OnItemTouchListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener
-keep class * extends android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnItemTouchListener
-keep class * extends android.support.v7.widget.RecyclerView$OnItemTouchListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener
-keep class * extends android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnItemTouchListener
-keep class * extends android.support.v7.widget.RecyclerView$OnItemTouchListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener
-keep class * extends android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnItemTouchListener
-keep class * extends android.support.v7.widget.RecyclerView$OnItemTouchListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener
-keep class * extends android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnItemTouchListener
-keep class * extends android.support.v7.widget.RecyclerView$OnItemTouchListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener
-keep class * extends android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnItemTouchListener
-keep class * extends android.support.v7.widget.RecyclerView$OnItemTouchListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener
-keep class * extends android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnItemTouchListener
-keep class * extends android.support.v7.widget.RecyclerView$OnItemTouchListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener
-keep class * extends android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnItemTouchListener
-keep class * extends android.support.v7.widget.RecyclerView$OnItemTouchListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener
-keep class * extends android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnItemTouchListener
-keep class * extends android.support.v7.widget.RecyclerView$OnItemTouchListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener
-keep class * extends android.support.v7.widget.RecyclerView$OnChildAttachStateChangeListener

# Keep all classes extending android.support.v7.widget.RecyclerView$OnItemTouchListener
-keep class * extends android.support.v7