package com.example.demo.model.util;

import com.example.demo.model.entity.ParkingInformation;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Map;
import java.util.stream.Stream;


public class CreatePDF {

    public static void createPDF(
            Map<String, Object> model,
            Document document,
            PdfWriter writer,
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        PdfPTable table = new PdfPTable(7);
        Stream.of("Street", "Car number", "Abonnemnet", "Start time", "End time", "Price", "Parking status")
                .forEach(columnTitle -> {
                    PdfPCell header = new PdfPCell();
                    header.setBackgroundColor(BaseColor.LIGHT_GRAY);
                    header.setBorderWidth(2);
                    header.setPhrase(new Phrase(columnTitle));
                    table.addCell(header);
                });

        ArrayList<ParkingInformation> parkingInformations = (ArrayList<ParkingInformation>) model.get("modelObject");
        for (ParkingInformation parkingInformation : parkingInformations) {
            table.addCell(parkingInformation.getParking().getStreetName() + "/" + parkingInformation.getParking().getStreetNumber());
            table.addCell(parkingInformation.getCar().getNumber());
            table.addCell(parkingInformation.getAbonnement().getName());
            table.addCell(parkingInformation.getStartTime().toString());
            table.addCell(parkingInformation.getEndTime().toString());
            table.addCell(String.valueOf(parkingInformation.getPrice()));
            table.addCell(parkingInformation.getParkingStatus().toString());
        }
        document.add(table);
        document.close();
    }

}

