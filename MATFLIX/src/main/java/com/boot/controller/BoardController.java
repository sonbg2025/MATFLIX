package com.boot.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.boot.dto.BoardAttachDTO;
import com.boot.dto.BoardDTO;
import com.boot.dto.CommentDTO;
import com.boot.dto.TeamDTO;
import com.boot.service.BoardService;
import com.boot.service.CommentService;
import com.boot.service.UploadService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class BoardController {
	@Autowired
	private BoardService service;

	@Autowired
	private CommentService commentService;

	@Autowired
	private UploadService uploadService;

//	@RequestMapping("/main")
//	public String main() {
//		log.info("@# main()");
//		return "main";
//	}

//	@RequestMapping("/main")
//	public String list(Model model) {
//		log.info("@# list()");
//
//		ArrayList<BoardDTO> list = service.list();
//		model.addAttribute("list", list);
//
//		return "main";
//	}
	@GetMapping("/main")
	public String main(HttpSession session, Model model) {
		// 세션에서 사용자 정보 가져오기 (로그인 안되어 있어도 null일 수 있음)
		TeamDTO user = (TeamDTO) session.getAttribute("user");

		// 로그인한 사용자 정보가 있다면 모델에 추가
		if (user != null) {
			model.addAttribute("user", user);
		}

		return "main"; // 로그인 여부와 관계없이 main 페이지로 이동
	}

	@RequestMapping("/write")
	public String write(BoardDTO boardDTO) {
		log.info("@# write()");
		log.info("@# boardDTO=>" + boardDTO);

		if (boardDTO.getAttachList() != null) {
			boardDTO.getAttachList().forEach(attach -> log.info("@# attach=>" + attach));
		}

		service.write(boardDTO);

		return "redirect:list";
	}

	@RequestMapping("/write_view")
	public String write_view() {
		log.info("@# write_view()");

		return "write_view";
	}

	@RequestMapping("/content_view")
	public String content_view(@RequestParam HashMap<String, String> param, Model model) {
		log.info("@# content_view()");
		log.info("@# param=>" + param);

		BoardDTO dto = service.contentView(param);
		model.addAttribute("content_view", dto);
		service.hitUp(param);

		model.addAttribute("pageMaker", param);

		ArrayList<CommentDTO> commentList = commentService.findAll(param);
		model.addAttribute("commentList", commentList);

		return "content_view";
	}

	@RequestMapping("/modify")
	public String modify(@RequestParam HashMap<String, String> param, RedirectAttributes rttr) {
		log.info("@# modify()");
		log.info("@# param=>" + param);

		service.modify(param);

		rttr.addAttribute("pageNum", param.get("pageNum"));
		rttr.addAttribute("amount", param.get("amount"));

		return "redirect:list";
	}

	@RequestMapping("/delete")
	public String delete(@RequestParam HashMap<String, String> param, RedirectAttributes rttr) {
		log.info("@# delete()");
		log.info("@# param=>" + param);
		log.info("@# boardNo=>" + param.get("boardNo"));

		List<BoardAttachDTO> fileList = uploadService.getFileList(Integer.parseInt(param.get("boardNo")));
		log.info("@# fileList=>" + fileList);

		service.delete(param);
		uploadService.deleteFiles(fileList);
		commentService.boardCommentDelete(param);

		rttr.addAttribute("pageNum", param.get("pageNum"));
		rttr.addAttribute("amount", param.get("amount"));

		return "redirect:list";
	}
}