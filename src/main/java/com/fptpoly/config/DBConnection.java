package com.fptpoly.config;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class DBConnection {

    private static String url;
    private static String username;
    private static String password;


    static {

        try {

            Properties properties = new Properties();


            try (InputStream input =
                         DBConnection.class
                                 .getClassLoader()
                                 .getResourceAsStream("database.properties")) {


                if (input == null) {

                    System.out.println(
                            "❌ Không tìm thấy file database.properties"
                    );

                } else {


                    properties.load(input);


                    url =
                            properties.getProperty("db.url");


                    username =
                            properties.getProperty("db.username");


                    password =
                            properties.getProperty("db.password");


                    Class.forName(
                            "com.microsoft.sqlserver.jdbc.SQLServerDriver"
                    );


                    System.out.println(
                            "✅ Load cấu hình database thành công!"
                    );

                }


            }


        } catch (Exception e) {

            System.out.println(
                    "❌ Lỗi khởi tạo database!"
            );

            e.printStackTrace();

        }

    }



    public static Connection getConnection() {


        try {


            if (url == null
                    || username == null
                    || password == null) {


                System.out.println(
                        "❌ Thiếu thông tin kết nối database!"
                );


                return null;

            }


            return DriverManager.getConnection(
                    url,
                    username,
                    password
            );


        } catch (Exception e) {


            System.out.println(
                    "❌ Không thể kết nối SQL Server!"
            );


            e.printStackTrace();


            return null;

        }

    }




    public static void main(String[] args) {


        System.out.println(
                "===== TEST DATABASE CONNECTION ====="
        );


        Connection connection =
                DBConnection.getConnection();



        if (connection != null) {


            System.out.println(
                    "🎉 KẾT NỐI DATABASE THÀNH CÔNG!"
            );


            try {

                connection.close();

                System.out.println(
                        "Đã đóng kết nối."
                );


            } catch (Exception e) {

                e.printStackTrace();

            }



        } else {


            System.out.println(
                    "💥 KẾT NỐI DATABASE THẤT BẠI!"
            );


        }


    }

}