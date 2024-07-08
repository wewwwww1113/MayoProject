package com.kh.springProject.rank.model.service;

import java.util.List;

import com.kh.springProject.review.model.vo.ReviewStar;

public interface RankService {

	List<ReviewStar> getAllStars(ReviewStar rs);

	//평균 별점
	int avgStar(int toiletNo);

}
