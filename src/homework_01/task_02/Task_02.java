package homework_01.task_02;

/*
Задание 2+
Используя дополнительное задания все вопросы записать в текстовом файле с новой строки каждый
и используя потоки ввода-вывода считать с файла все запросы и выполнить.
 */

import java.io.*;
import java.sql.*;

public class Task_02 {

    private static final String URL = "jdbc:mysql://localhost:3306/MyJoinsDB?useSSL=false";
    private static final String LOGIN = "root";
    private static final String PASSWORD = "root"; // "root";

    public static void main(String[] args) throws IOException {

        registerDriver();

        FileWriter writerSimple = new FileWriter("task_02.txt");

        writerSimple.write("INSERT INTO Task_06(surnames, name, phone, rating, age )  VALUES(?,?,?,?,?)\n" +
                               "SELECT * FROM Task_06");

        writerSimple.close();
        // Создали объект файла по ссылке
        File f1 = new File("task_02.txt");
        // Считываем текстовый файл в пакете
        BufferedReader br = new BufferedReader(new FileReader(f1));

        String temp;
        int count = 0;
        while ((temp = br.readLine()) != null) {
            count += 1 ;
            if (count == 1){
                setAllTable (temp,"Фамилия", "Имя","380677827744", 5.6, 28);
            } else {
                getAllTable(temp);
            }

        }
        br.close();
    }


    private static void setAllTable (String InsertNew, String surnames, String name, String phone, double rating, int age ) {
        Connection connection = null;
        //Теперь используем PreparedStatement (из пакета java.sql)
        PreparedStatement statement = null;

        try {
            connection = DriverManager.getConnection(URL, LOGIN, PASSWORD);
            statement = connection.prepareStatement(InsertNew);

            //Вызываем у statement методы для вставки в таблицу данных соответствующего типа
            // Указываем индекс столбца и передаем данные для этой строки
            statement.setString(1, surnames);
            statement.setString(2, name);
            statement.setString(3, phone);
            statement.setDouble(4, rating);
            statement.setInt(5, age);

            // запускаем на выполнение данный стейтмент
            statement.execute();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
                statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private static void getAllTable(String GET_ALL) {
        Connection connection = null;
        PreparedStatement statement_01 = null;
        try {
            connection = DriverManager.getConnection(URL, LOGIN, PASSWORD);
            // В statement передаем константу
            statement_01 = connection.prepareStatement(GET_ALL);

            // Загоняем в ResultSet полученные данные
            // executeQuery уже без параметров, тк. в синтаксисе выше мы передали содержание запроса
            ResultSet resultSet_1 = statement_01.executeQuery();

            while (resultSet_1.next()) {
                String surnames  = resultSet_1.getString("surnames");
                String name  = resultSet_1.getString("name");
                String phone  = resultSet_1.getString("phone");
                double rating  = resultSet_1.getDouble("rating");
                int age = resultSet_1.getInt("age");

                System.out.println( surnames + " " + name + " " + phone + " " + rating + " " + age );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
                statement_01.close();

            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }


    private static void registerDriver() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Class.forName("com.mysql.jdbc.Driver"); // deprecated
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

}
