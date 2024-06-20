package com.kh.springProject.map.model.vo;

import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Data;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Map {
	private int toiletNo;           // TOILET_NO NUMBER(38,0)
    private String toiletName;      // TOILET_NAME VARCHAR2(255 BYTE)
    private String toiletAddress;   // TOILET_ADDRESS VARCHAR2(1000 BYTE)
    private int toiletMhB;          // TOILET_MH_B NUMBER(38,0)
    private int toiletMhS;          // TOILET_MH_S NUMBER(38,0)
    private int toiletWhB;          // TOILET_WH_B NUMBER(38,0)
    private String toiletOpen;      // TOILET_OPEN VARCHAR2(255 BYTE)
    private double latitude;        // LATITUDE NUMBER(20,15)
    private double longitude;       // LONGITUDE NUMBER(20,15)
    private String toiletSeat;      // TOILET_SEAT VARCHAR2(50 BYTE)
    private char toiletSafeBell;    // TOILET_SAFEBELL CHAR(1 BYTE)
    private char toiletDiaper;      // TOILET_DIAPER CHAR(1 BYTE)
    private String toiletUpdate;    // TOILET_UPDATE VARCHAR2(255 BYTE)

}
