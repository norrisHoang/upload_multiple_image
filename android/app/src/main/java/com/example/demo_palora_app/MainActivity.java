package com.example.demo_palora_app;

import android.Manifest;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
import android.util.Base64;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "demo.get.image";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
                if (call.method.equals("get_images")) {
                    getImages(call, result);
                } else {
                    result.notImplemented();
                }
            }


        });
    }

    private void getImages(MethodCall call, Result result) {
        if (ContextCompat.checkSelfPermission(MainActivity.this, Manifest.permission.READ_EXTERNAL_STORAGE)
                != PackageManager.PERMISSION_GRANTED) {
            // Xin quyền truy cập ảnh trong máy
            ActivityCompat.requestPermissions(MainActivity.this,
                    new String[]{Manifest.permission.READ_EXTERNAL_STORAGE},
                    999);
        }
//        tạo List chuỗi chứa data image
//                List<String> ds = new ArrayList<>();
//        gồm những thứ cần lấy trong ảnh
        String[] projection = {
                MediaStore.Images.ImageColumns._ID,
                MediaStore.Images.ImageColumns.DISPLAY_NAME,
                MediaStore.Images.ImageColumns.DATA,
        };
//        Con trỏ để lấy dữ liệu ảnh
        Cursor cursor = getContentResolver().query(MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
                projection, null, null, null);
//        nếu có dữ liệu thì mới đọc
//        ArrayList<ImageModel> imageModelList = new ArrayList<ImageModel>();
        List<String> list = new ArrayList<String>();
        if (cursor.getCount() > 0) {
//            Đưa con trỏ về đầu
            cursor.moveToFirst();

            while (!cursor.isAfterLast()) {
//                Log.e("--------------" + id , "----------------" + name);
//                for (int i = 0; i < cursor.getColumnCount(); i++) {
//                    ds.add(String.valueOf(cursor.getString(i)));
//                }
                @SuppressLint("Range") String data = cursor.getString(cursor.getColumnIndex(MediaStore.Images.Media.DATA));

                list.add(data);
                cursor.moveToNext();
            }
            cursor.close();
        }

        result.success(list);
//        setTitle("Show Image with Size = " + imageModelList.size());
//        Intent intent = new Intent(Intent.ACTION_VIEW);
//        intent.setData(Uri.parse(url));
//        activity.startActivity(intent);
//        result.success((Object) true);
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
//        Xin quyền lại
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_EXTERNAL_STORAGE)
                != PackageManager.PERMISSION_GRANTED) {
            // xin quyen
            ActivityCompat.requestPermissions(this,
                    new String[]{Manifest.permission.READ_EXTERNAL_STORAGE},
                    999);
            Toast.makeText(getApplicationContext(), "ban chua cap quyen",
                    Toast.LENGTH_SHORT).show();
        } else {

            Toast.makeText(getApplicationContext(), "ok hazz",
                    Toast.LENGTH_SHORT).show();
        }
    }
}