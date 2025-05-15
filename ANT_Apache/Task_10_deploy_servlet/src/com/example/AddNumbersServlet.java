package com.example;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class AddNumbersServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        response.setContentType("text/html");
        
        
        String num1 = request.getParameter("num1");
        String num2 = request.getParameter("num2");
        
        int sum = 0;
        if (num1 != null && num2 != null) {
            try {
                int number1 = Integer.parseInt(num1);
                int number2 = Integer.parseInt(num2);
                sum = number1 + number2;
            } catch (NumberFormatException e) {
                sum = 0;
            }
        }
        
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h3>Sum of " + num1 + " and " + num2 + " is: " + sum + "</h3>");
        out.println("<a href='index.html'>Go back</a>");
        out.println("</body></html>");
    }
}