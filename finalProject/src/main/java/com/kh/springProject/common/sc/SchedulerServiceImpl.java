package com.kh.springProject.common.sc;


import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import lombok.extern.slf4j.Slf4j;

import java.io.*;
import java.net.URL;
import java.util.*;

@Slf4j
@Service
public class SchedulerServiceImpl {

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Scheduled(cron = "0 0 0 1 * *")
    public void updateToiletData() {
        String fileUrl = "https://www.localdata.go.kr/lif/etcDataDownload.do?localCodeEx=6110000&sidoCodeEx=6110000&sigunguCodeEx=&opnSvcIdEx=12_04_01_E&startDateEx=&endDateEx=&fileType=xlsx&opnSvcNmEx=%25EA%25B3%25B5%25EC%25A4%2591%25ED%2599%2594%25EC%259E%25A5%25EC%258B%25A4%25EC%25A0%2595%25EB%25B3%25B4";
        String localFilePath = "C:/finalProject-workspace/springProject-2/src/main/resources/uploadFiles/똥.xlsx";

        try {
        	SSLUtil.disableSSLVerification();
            downloadExcelFile(fileUrl, localFilePath);
            List<Map<String, Object>> dataList = readAndCleanExcelFile(localFilePath);
            updateDatabase(dataList);
        } catch (IOException e) {
            log.error("Error during scheduled task", e);
        }
    }

    private void downloadExcelFile(String fileUrl, String localFilePath) throws IOException {
        URL url = new URL(fileUrl);
        try (InputStream is = url.openStream();
             OutputStream os = new FileOutputStream(localFilePath)) {
            byte[] b = new byte[2048];
            int length;
            while ((length = is.read(b)) != -1) {
                os.write(b, 0, length);
            }
        }
    }

    private List<Map<String, Object>> readAndCleanExcelFile(String filePath) throws IOException {
        List<Map<String, Object>> dataList = new ArrayList<>();
        try (InputStream is = new FileInputStream(filePath);
             Workbook workbook = new XSSFWorkbook(is)) {
            Sheet sheet = workbook.getSheetAt(0);
            int startRow = 1;
            for (int i = startRow; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row == null) {
                    continue; // 빈 행 처리
                }
                Map<String, Object> data = new HashMap<>();
                Cell latitudeCell = row.getCell(20); // 위도 셀
                Cell longitudeCell = row.getCell(21); // 경도 셀

                Double latitude = getDoubleCellValue(latitudeCell);
                Double longitude = getDoubleCellValue(longitudeCell);
                
                if (latitude == null || longitude == null) {
                    // 위도 또는 경도가 없는 경우 무시
                    log.warn("Skipping row {} due to missing latitude or longitude", i);
                    continue;
                }

                // TOILET_NO, TOILET_MH_B, TOILET_MH_S, TOILET_WH_B 값 타입 확인 및 변환
                int toiletNo = (int) getNumericCellValue(row.getCell(0));
                int toiletMhB = (int) getNumericCellValue(row.getCell(8));
                int toiletMhS = (int) getNumericCellValue(row.getCell(9));
                int toiletWhB = (int) getNumericCellValue(row.getCell(13));

                // 필드 널값 체크 후 데이터 추가
                if (latitude != null && longitude != null) {
                    data.put("LATITUDE", latitude);              // LATITUDE NUMBER(20,15)
                    data.put("LONGITUDE", longitude);             // LONGITUDE NUMBER(20,15)
                }
                data.put("TOILET_NO", toiletNo);          // TOILET_NO NUMBER(38,0)
                data.put("TOILET_NAME", getStringValue(row.getCell(3)));             // TOILET_NAME VARCHAR2(255 BYTE)
                data.put("TOILET_ADDRESS", getStringValue(row.getCell(4)));          // TOILET_ADDRESS VARCHAR2(1000 BYTE)
                data.put("TOILET_MH_B", toiletMhB);      // TOILET_MH_B NUMBER(38,0)
                data.put("TOILET_MH_S", toiletMhS);      // TOILET_MH_S NUMBER(38,0)
                data.put("TOILET_WH_B", toiletWhB);      // TOILET_WH_B NUMBER(38,0)
                data.put("TOILET_OPEN", getStringValue(row.getCell(18)));             // TOILET_OPEN VARCHAR2(255 BYTE)
                data.put("TOILET_SEAT", getStringValue(row.getCell(23)));            // TOILET_SEAT VARCHAR2(50 BYTE)
                data.put("TOILET_SAFEBELL", getCharCellValue(row.getCell(25))); // TOILET_SAFEBELL CHAR(1 BYTE)
                data.put("TOILET_DIAPER", getCharCellValue(row.getCell(28)));   // TOILET_DIAPER CHAR(1 BYTE)
                data.put("TOILET_UPDATE", getStringValue(row.getCell(31)));          // TOILET_UPDATE VARCHAR2(255 BYTE)
                // 필요한 다른 필드 추가
                dataList.add(data);
            }
        }
        return dataList;
    }

    private void updateDatabase(List<Map<String, Object>> dataList) {
        try {
            sqlSession.delete("mapMapper.deleteAllToilets"); // 기존 데이터 삭제

            for (Map<String, Object> data : dataList) {
                sqlSession.insert("mapMapper.insertToilet", data); // 새로운 데이터 삽입
            }
        } catch (Exception e) {
            log.error("Error updating database", e);
        }
    }

    private Double getDoubleCellValue(Cell cell) {
        if (cell == null) {
            return null;
        }

        switch (cell.getCellType()) {
            case NUMERIC:
                return cell.getNumericCellValue();
            case STRING:
                try {
                    return Double.parseDouble(cell.getStringCellValue());
                } catch (NumberFormatException e) {
                    return null;
                }
            default:
                return null;
        }
    }

    private double getNumericCellValue(Cell cell) {
        if (cell == null) {
            return 0; // 기본값이 0으로 설정 또는 예외 처리 필요
        }

        switch (cell.getCellType()) {
            case NUMERIC:
                return cell.getNumericCellValue();
            case STRING:
                try {
                    return Double.parseDouble(cell.getStringCellValue());
                } catch (NumberFormatException e) {
                    return 0; // 기본값이 0으로 설정 또는 예외 처리 필요
                }
            default:
                return 0; // 기본값이 0으로 설정 또는 예외 처리 필요
        }
    }

    private String getStringValue(Cell cell) {
        if (cell == null) {
            return null;
        }
        return cell.getStringCellValue();
    }

    private char getCharCellValue(Cell cell) {
        if (cell == null || cell.getCellType() != CellType.STRING) {
            return '\0'; // 또는 다른 기본값으로 설정
        }
        String cellValue = cell.getStringCellValue();
        if (cellValue.isEmpty()) {
            return '\0'; // 또는 다른 기본값으로 설정
        }
        return cellValue.charAt(0);
    }
}