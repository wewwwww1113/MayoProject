package com.kh.springProject.store.model.service;

import java.util.List;

import com.kh.springProject.store.model.vo.Cart;
import com.kh.springProject.store.model.vo.Store;

public interface StoreService {

    List<Store> selectAllStores();

    Store findByStoreNo(int storeNo);

    int insertStore(Store store);

    int updateStore(Store store);

    int deleteStore(int storeNo);

	int addToCart(String memberNo, int storeNo, int quantity);
	
	List<Cart> getCartItems(String memberNo);
	
	int deleteCartById(int cartId) throws Exception;
	
	void updateCartQuantity(int cartId, int quantity);
}