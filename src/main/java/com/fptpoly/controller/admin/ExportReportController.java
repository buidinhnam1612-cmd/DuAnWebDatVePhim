package com.fptpoly.controller.admin;

import com.fptpoly.model.Report;
import com.fptpoly.repository.ReportRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.IOException;
import java.util.List;


@WebServlet("/admin/export-report")
public class ExportReportController extends HttpServlet {


    private ReportRepository reportRepository =
            new ReportRepository();



    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {



        List<Report> reportList =
                reportRepository.getTopMovie();

        System.out.println("Số dòng Excel: " + reportList.size());

        for(Report r : reportList){

            System.out.println(
                    r.getTenPhim()
                            + " - "
                            + r.getTenRap()
            );

        }


        Workbook workbook =
                new XSSFWorkbook();



        Sheet sheet =
                workbook.createSheet("Bao Cao");



        Row header =
                sheet.createRow(0);


        header.createCell(0)
                .setCellValue("Tên phim");


        header.createCell(1)
                .setCellValue("Tên rạp");


        header.createCell(2)
                .setCellValue("Số vé");


        header.createCell(3)
                .setCellValue("Doanh thu");



        int index = 1;



        for(Report report : reportList){


            Row row =
                    sheet.createRow(index++);



            row.createCell(0)
                    .setCellValue(report.getTenPhim());


            row.createCell(1)
                    .setCellValue(report.getTenRap());


            row.createCell(2)
                    .setCellValue(report.getSoVe());


            row.createCell(3)
                    .setCellValue(
                            report.getDoanhThu()
                                    .doubleValue()
                    );

        }



        for(int i = 0; i < 4; i++){

            sheet.autoSizeColumn(i);

        }



        response.setContentType(
                "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        );


        response.setHeader(
                "Content-Disposition",
                "attachment; filename=bao-cao-doanh-thu.xlsx"
        );



        workbook.write(
                response.getOutputStream()
        );


        workbook.close();

    }
}