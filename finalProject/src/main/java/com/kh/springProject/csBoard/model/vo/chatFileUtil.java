package com.kh.springProject.csBoard.model.vo;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class chatFileUtil {

    private static final String FILE_DIRECTORY = "D:\\devTools\\sts-bundle\\sts-3.9.14.RELEASE\\"; // 저장할 디렉토리 경로
    private static final String FILE_NAME_PREFIX = "chat_history_";

    public static void saveMessage(String sender, String content) {
        String fileName = getFileName(); // 현재 날짜에 맞는 파일 이름 생성
        String filePath = FILE_DIRECTORY + fileName;

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            String message = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))
                    + " - " + sender + ": " + content + "\n";
            writer.write(message);
        } catch (IOException e) {
            e.printStackTrace();
        }

        System.out.println(sender);
        System.out.println(content);
    }

    private static String getFileName() {
        LocalDateTime currentDate = LocalDateTime.now();
        return FILE_NAME_PREFIX + currentDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) + ".txt";
    }
}
