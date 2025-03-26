/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author user
 */
@WebServlet(name = "sum", urlPatterns = {"/sum"})
public class sum extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String arr_str = request.getParameter("arr");
        String type = request.getParameter("type");

        String[] arr = arr_str.split(",");
        for (int i = 0; i < arr.length; i++) {
            int num = Integer.parseInt(arr[i]);
            if (num < 0) {
                out.println("You must enter integer!!!");
                return;
            }

        }
        int sum = 0;
        if (type.equals("odd")) {
            for (int i = 0; i < arr.length; i++) {
                int num = Integer.parseInt(arr[i]);
                if (num % 2 == 0) {
                    sum += num;

                }

            }

        } else {
             for (int i = 0; i < arr.length; i++) {
                int num = Integer.parseInt(arr[i]);
                if (num % 2 != 0) {
                    sum += num;

                }

            }
            
        }
        out.println(sum);
    }

}
