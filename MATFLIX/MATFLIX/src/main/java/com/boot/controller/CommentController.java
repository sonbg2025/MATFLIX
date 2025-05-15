package com.boot.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boot.dto.BoardDTO;
import com.boot.dto.CommentDTO;
import com.boot.service.BoardService;
import com.boot.service.CommentService;
import com.boot.service.NotificationService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/comment")
public class CommentController {

	@Autowired
	private CommentService service;

	@Autowired
	private BoardService boardService;

	@Autowired
	private NotificationService notificationService;

	@RequestMapping("/save")
	public @ResponseBody ArrayList<CommentDTO> save(@RequestParam HashMap<String, String> param) {
		log.info("@# save()");
		log.info("@# param=>" + param);

		service.save(param);

		HashMap<String, String> boardNo = new HashMap<>();
		boardNo.put("boardNo", param.get("boardNo"));

		BoardDTO b_dto = boardService.contentView(boardNo);

		log.info("b_dto => " + b_dto);
		int mf_no = b_dto.getMf_no();
		int b_no = b_dto.getBoardNo();
		log.info("mf_no => " + mf_no);
		log.info("b_no => " + b_no);

		int userNo = Integer.parseInt(param.get("userNo"));

		notificationService.add_notification(userNo, mf_no, b_no, 2);

		ArrayList<CommentDTO> commentList = service.findAll(param);
		return commentList;
	}

	@RequestMapping("/delete")
	public @ResponseBody void userCommentDelete(@RequestParam HashMap<String, String> param) {
		log.info("@# userCommentDelete()");
		log.info("@# param=>" + param);

		service.userCommentDelete(param);
	}

	@RequestMapping("/list")
	public @ResponseBody ArrayList<CommentDTO> findAll(@RequestParam HashMap<String, String> param) {
		log.info("@# findAll()");
		log.info("@# param=>" + param);

		ArrayList<CommentDTO> commentList = service.findAll(param);
		return commentList;
	}
}