package com.boot.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.dao.TeamDAO;
import com.boot.dto.TeamDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class TeamServiceImpl implements TeamService {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void recruit(HashMap<String, String> param) {
		TeamDAO dao = sqlSession.getMapper(TeamDAO.class);
		System.out.println(param);
		dao.recruit(param);
	}

	@Override
	public ArrayList<TeamDTO> list() {
		TeamDAO dao = sqlSession.getMapper(TeamDAO.class);
		ArrayList<TeamDTO> list = dao.list();
		return list;
	}

	@Override
	public TeamDTO find_list(@Param("mf_id") String mf_id) {
		TeamDAO dao = sqlSession.getMapper(TeamDAO.class);
		TeamDTO find_list = dao.find_list(mf_id);
		return find_list;
	}

	@Override
	public int login(@Param("mf_id") String mf_id, @Param("mf_pw") String mf_pw) {
		int re = -1;

		TeamDAO dao = sqlSession.getMapper(TeamDAO.class);
		re = dao.login(mf_id, mf_pw);

		return re;
	}

	@Override
	public void update_ok(HashMap<String, String> param) {
		TeamDAO dao = sqlSession.getMapper(TeamDAO.class);
		System.out.println(param);
		dao.update_ok(param);
	}

	@Override
	public void delete_ok(String id) {
		TeamDAO dao = sqlSession.getMapper(TeamDAO.class);
		dao.delete_ok(id);
	}

	@Override
	public void nickname(@Param("mf_nickname") String mf_nickname, @Param("mf_id") String mf_id) {
		TeamDAO dao = sqlSession.getMapper(TeamDAO.class);
		dao.nickname(mf_nickname, mf_id);
	}
}