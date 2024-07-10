package com.kh.springProject.rank.model.service;

import java.util.ArrayList;
import java.util.List;

import com.kh.springProject.rank.model.vo.Rank;
import com.kh.springProject.review.model.vo.ReviewStar;

public interface RankService {

	List<ReviewStar> getAllStars(ReviewStar rs);

	//평균 별점
	ArrayList<Rank> avgStar();

}
