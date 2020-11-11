

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("Login servlet");
		HttpSession session = request.getSession(); //사용자가 보낸 요청의 정보를 session이라는 변수에 담음
		String id = request.getParameter("id"); //form의 id 값 가져옴
		System.out.println("id:"+id);
		String pwd = request.getParameter("pwd"); //form의 pwd 값 가져옴
		System.out.println("pwd:"+pwd);
		
		session.setAttribute("id", id);  //id 정보 session으로 전달 -> 페이지에서 확인 가능
		session.setAttribute("pwd", pwd); //패스워드 정보 session으로 전달-> 페이지에서 비밀번호 변경을 위해 쓰임
		
		
		String login_suc = "LoginPage.jsp";
		System.out.println(login_suc);
		response.sendRedirect(login_suc); //LoginPage로 url 전환하라는 응답
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
