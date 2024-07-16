package com.kh.springProject.csBoard.model.vo;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;


public class schedulerMain {
	  public static void main(String[] args) {
	        ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);

	        // 매일 자정에 실행되도록 설정
	        scheduler.scheduleAtFixedRate(new Runnable() {
	            @Override
	            public void run() {
	                chatFileUtil.saveMessage("SYSTEM", "새로운 파일이 생성되었습니다."); // 예시 메시지
	            }
	        }, calculateInitialDelay(), 24 * 60 * 60, TimeUnit.SECONDS); // 매일 24시간(1일)마다 실행

	        // JVM 종료 시 스케줄러 종료
	        Runtime.getRuntime().addShutdownHook(new Thread(scheduler::shutdown));
	    }

	    private static long calculateInitialDelay() {
	        LocalDateTime now = LocalDateTime.now();
	        LocalDateTime nextDay = now.plusDays(1).withHour(0).withMinute(0).withSecond(0);
	        return Duration.between(now, nextDay).getSeconds(); // 다음 자정까지 남은 시간을 초로 계산
	    }
	    
	    
	    
	    
}
