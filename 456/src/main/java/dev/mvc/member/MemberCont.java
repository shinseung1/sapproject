package dev.mvc.member;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import nation.web.tool.Tool;

import org.springframework.web.bind.annotation.ResponseBody;

@Controller

public class MemberCont {

	@Autowired
	@Qualifier("dev.mvc.member.MemberProc")
	private MemberProcInter memberProc;

	public MemberCont() {
	}

	@RequestMapping(value = "/member/create.do", method = RequestMethod.GET)
	public ModelAndView checkid() {

		ModelAndView mav = new ModelAndView();
		mav.setViewName("/member/create");

		return mav;
	}

	@RequestMapping(value = "/member/checkId.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public String checkId(String id) {
		System.out.println("--> checkId() GET executed");

		JSONObject obj = new JSONObject();

		int cnt = memberProc.checkid(id);
		// System.out.println("--> id: " + id);
		// System.out.println("--> cnt: " + cnt);

		obj.put("cnt", cnt);

		return obj.toJSONString();
	}

	@RequestMapping(value = "/member/create.do", method = RequestMethod.POST)
	public ModelAndView create(HttpServletRequest request, MemberVO memberVO) {
		System.out.println("--> create() POST called.");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/member/message"); // webapp/member/message.jsp

		ArrayList<String> msgs = new ArrayList<String>();
		ArrayList<String> links = new ArrayList<String>();

		String root = request.getContextPath();

		// 중복 아이디 검사
		int count = memberProc.checkid(memberVO.getId());
		if (count > 0) {
			msgs.add("ID가 중복됩니다.");
			msgs.add("폼에서 회원가입을해주세요. ☏ 000-0000-0000");
			links.add("<button type='button' onclick=\"history.back()\">다시 시도</button>");
		} else {
			// 회원 가입 처리
			if (memberProc.create(memberVO) == 1) {
				msgs.add("회원 가입이 완료되었습니다.");
				msgs.add("가입해 주셔서 감사합니다.");
				links.add("<button type='button' onclick=\"location.href='./login.do'\">로그인</button>");

			} else {
				msgs.add("회원 가입에 실패했습니다.");
				msgs.add("죄송하지만 다시한번 시도해주세요. ☏ 000-0000-0000");
				links.add("<button type='button' onclick=\"history.back()\">다시 시도</button>");

			}

		}

		links.add("<button type='button' onclick=\"location.href='" + root + "/home.do'\">홈페이지</button>");

		mav.addObject("msgs", msgs);
		mav.addObject("links", links);

		return mav;
	}

	@RequestMapping(value = "/member/list.do", method = RequestMethod.GET)

	public ModelAndView list() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/member/list");

		List<MemberVO> list = memberProc.list();
		mav.addObject("list", list);
		return mav;

	}

	@RequestMapping(value = "/member/read.do", method = RequestMethod.GET)
	public ModelAndView read(int mno) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/member/read");
		MemberVO memberVO = memberProc.read(mno);
		mav.addObject("memberVO", memberVO);
		return mav;

	}

	@RequestMapping(value = "/member/update.do", method = RequestMethod.GET)

	public ModelAndView udate(HttpServletRequest request, MemberVO memberVO) {
		ModelAndView mav = new ModelAndView();

		int count = memberProc.update(memberVO);
		mav.setViewName("redirect:/member/message_update.jsp?count=" + count + "&mno=" + memberVO.getMno());

		return mav;
	}

	@RequestMapping(value = "/member/passwd_update.do", method = RequestMethod.GET)
	public ModelAndView passwd_update(int mno) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/member/passwd_update"); // webapp/member/passwd_update.jsp

		mav.addObject("mno", mno);

		return mav;
	}

	@RequestMapping(value = "/member/passwd_update.do", method = RequestMethod.POST)
	public ModelAndView passwd_update(HttpServletRequest request, MemberVO memberVO) {
		System.out.println("--> passwd_update() POST called.");
		ModelAndView mav = new ModelAndView();

		// webapp/member/message_passwd.jsp
		mav.setViewName("/member/message_passwd");

		int count = memberProc.passwd_update(memberVO);
		mav.setViewName("redirect:/member/message_passwd.jsp?count=" + count + "&mno=" + memberVO.getMno());

		return mav;
	}

	/**
	 * 관리자의 회원 삭제 폼
	 * 
	 * @param mno
	 *            삭제할 회원 번호
	 * @return 삭제할 회원 정보
	 */
	@RequestMapping(value = "/member/delete.do", method = RequestMethod.GET)
	public ModelAndView delete(int mno) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/member/delete"); // /webapp/member/delete.jsp

		MemberVO memberVO = memberProc.read(mno);

		mav.addObject("memberVO", memberVO);

		return mav;
	}

	/**
	 * 관리자의 회원 삭제 처리
	 * 
	 * @param request
	 * @param mno
	 *            삭제할 회원 번호
	 * @return 삭제된 회원수
	 */
	@RequestMapping(value = "/member/delete.do", method = RequestMethod.POST)
	public ModelAndView delete(HttpServletRequest request, int mno) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/member/message_delete");

		int count = memberProc.delete(mno);
		mav.setViewName("redirect:/member/message_delete.jsp?count=" + count + "&mno=" + mno);

		return mav;
	}

	@RequestMapping(value = "/member/login.do", method = RequestMethod.GET) // 페이지 주소값
	public ModelAndView login(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/member/login_ck_form"); // /webapp/member/login_ck_form.jsp jsp파일명!

		Cookie[] cookies = request.getCookies();
		Cookie cookie = null;

		String ck_id = ""; // id 저장 변수
		String ck_id_save = ""; // id 저장 여부를 체크하는 변수
		String ck_passwd = ""; // passwd 저장 변수
		String ck_passwd_save = ""; // passwd 저장 여부를 체크하는 변수

		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				cookie = cookies[i]; // 쿠키 객체 추출

				if (cookie.getName().equals("ck_id")) {
					ck_id = cookie.getValue();
				} else if (cookie.getName().equals("ck_id_save")) {
					ck_id_save = cookie.getValue(); // Y, N
				} else if (cookie.getName().equals("ck_passwd")) {
					ck_passwd = cookie.getValue(); // 1234
				} else if (cookie.getName().equals("ck_passwd_save")) {
					ck_passwd_save = cookie.getValue(); // Y, N
				}
			}
		}

		mav.addObject("ck_id", ck_id);
		mav.addObject("ck_id_save", ck_id_save);
		mav.addObject("ck_passwd", ck_passwd);
		mav.addObject("ck_passwd_save", ck_passwd_save);

		return mav;
	}

	@RequestMapping(value = "/member/login.do", method = RequestMethod.POST)
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			MemberVO memberVO) {
		ModelAndView mav = new ModelAndView();

		String id = memberVO.getId();
		String passwd = memberVO.getPasswd();

		if (memberProc.login(id, passwd) != 1) {
			mav.setViewName("redirect:/member/message_login");
		} else {
			MemberVO old_memberVO = memberProc.readById(id);
			session.setAttribute("mno", old_memberVO.getMno());
			session.setAttribute("id", id);
			session.setAttribute("passwd", passwd);
			session.setAttribute("mname", old_memberVO.getMname());

			String id_save = Tool.checkNull(memberVO.getId_save());
			if (id_save.equals("Y")) {
				Cookie ck_id = new Cookie("ck_id", id);
				ck_id.setMaxAge(60 * 60 * 72 * 10); // 30 day, 초단위
				response.addCookie(ck_id);
			} else {
				Cookie ck_id = new Cookie("ck_id", "");
				ck_id.setMaxAge(0);
				response.addCookie(ck_id);
			}

			Cookie ck_id_save = new Cookie("ck_id_save", id_save);
			ck_id_save.setMaxAge(60 * 60 * 72 * 10); // 30 day
			response.addCookie(ck_id_save);

			String passwd_save = Tool.checkNull(memberVO.getPasswd());

			if (passwd_save.equals("Y")) {
				Cookie ck_passwd = new Cookie("ck_passwd", passwd);
				ck_passwd.setMaxAge(60 * 60 * 72 * 10); // 30 day, 초단위
				response.addCookie(ck_passwd);

			} else {
				Cookie ck_passwd = new Cookie("ck_passwd", "");
				ck_passwd.setMaxAge(0);
				response.addCookie(ck_passwd);
			}
			Cookie ck_passwd_save = new Cookie("ck_passwd_save", passwd_save);
			ck_passwd_save.setMaxAge(60 * 60 * 72 * 10);
			response.addCookie(ck_passwd_save);

			mav.setViewName("redirect:/home.do");
		}
		return mav;

	}

	@RequestMapping(value = "/member/logout.do", method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, HttpSession session) {
		ModelAndView mav = new ModelAndView();

		session.invalidate();
		mav.setViewName("redirect:/member/logout");

		return mav;
	}

	/**
	 * 로그아웃 처리
	 * 
	 * @param request
	 * @param session
	 * @return
	 */

	@RequestMapping(value = "member/list.do", method = RequestMethod.GET)
	public ModelAndView list(HttpSession session) {
		ModelAndView mav = new ModelAndView();

		if (Tool.isMember(session) == false) {
			mav.setViewName("redirect: /member/login_need");
		} else {
			mav.setViewName("/member/list");
		}
		List<MemberVO> list = memberProc.list();
		mav.addObject("list", list);
		return mav;
	}

	@RequestMapping(value = "/member/read_user.do", method = RequestMethod.GET)
	public ModelAndView read_user(int mno) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/member/read_user");

		MemberVO memberVO = memberProc.read(mno);
		mav.addObject("memberVO", memberVO);

		return mav;

	}

	@RequestMapping(value = "/member/update_user.do", method = RequestMethod.POST)
	public ModelAndView update_user(HttpServletRequest request, MemberVO memberVO) {
		ModelAndView mav = new ModelAndView();

		int cnt = memberProc.update(memberVO);
		mav.setViewName("redirect:/member/message_update_user");

		return mav;

	}

	@RequestMapping(value = "/member/passwd_update_user.do", method = RequestMethod.GET)
	public ModelAndView passwd_update_user() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/member/passwd_update");
		return mav;

	}

	@RequestMapping(value = "/member/passwd_update_user.do", method = RequestMethod.POST)
	public ModelAndView passwd_update_user(HttpServletRequest request, String old_passwd, int mno, String passwd) {
	ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/message_passwd_user"); 
   int old_passwd_count = memberProc.passwd_check(mno, old_passwd);
    String param = "";
    int count = 0;
    if(old_passwd_count == 1) {
    	count = memberProc.passwd_update(mno, passwd);
    	
    	
    } 
    param = "old_passwd_count=" + old_passwd_count + "&count=" + count; 
    mav.setViewName("redirect:/member/message_passwd_user.jsp?" + param); 
    
	
	return mav;
	}
	
	@RequestMapping( value = "/member/cancel.do" , method = RequestMethod.GET)
	public ModelAndView cancel() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/member/cancel");
		return mav;
	}
	
	@RequestMapping( value = "/member/cancel.do" , method = RequestMethod.POST)
	public ModelAndView cancel(HttpServletRequest request ,MemberVO memberVO ) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/member/cancel");
		int count =memberProc.update(memberVO);
		mav.setViewName("redirect:/member/message_cancel.jsp?count=" + count);
		return mav;
	}
}