package com.kh.springProject.common.portone.model.service;

import com.kh.springProject.common.portone.model.vo.Order;

public interface OrderService {

    int insertOrder(Order order);

    Order getOrder(String mcUid);
}