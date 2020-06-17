// Maria Medina Martinez and Caitlin Jung
// Project Team 34

import java.sql.*;

import static java.lang.System.exit;
import static java.lang.System.setOut;

import java.util.Date;
import java.util.Scanner;

public class pf34 {

    public static void main(String[] args) {
        // test correct args
        if(args.length < 3)
        {
            System.out.println("1 – Report Patient Information");
            System.out.println("2 – Report Primary Care Physician Information ");
            System.out.println("3 – Report Operation Information");
            System.out.println("4 – Update Patient Blood Type");
            System.out.println("5 – Exit Program");
            exit(0);
        }

        System.out.println("-------Oracle JDBC COnnection Testing ---------");
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");

        } catch (ClassNotFoundException e){
            System.out.println("Where is your Oracle JDBC Driver?");
            e.printStackTrace();
            return;
        }

        System.out.println("Oracle JDBC Driver Registered!");
        Connection connection = null;

        try {
            connection = DriverManager.getConnection(
                    "jdbc:oracle:thin:@csorcl.cs.wpi.edu:1521:orcl", args[0], args[1]);
        } catch (SQLException e) {
            System.out.println("Connection Failed! Check output console");
            e.printStackTrace();
            return;
        }
        System.out.println("Oracle JDBC Driver Connected!");


        Scanner reader = new Scanner(System.in);
        Statement stmt;
        ResultSet rset;
        String str;

        // Performing the query
        try {
            int choice = Integer.parseInt(args[2]);
            switch(choice){
                case 1:
                    System.out.println("Enter Patient's Healthcare ID:");
                    int healthID = reader.nextInt();
                    stmt = connection.createStatement();
                    str = "SELECT * FROM PATIENT where PATIENT.HEALTHCAREID=" + healthID;
                    rset = stmt.executeQuery(str);

                    int healthCareID = 0;
                    String firstName = "";
                    String lastName = "";
                    String city = "";
                    String state = "";
                    Date birthDate = new Date();
                    String bloodType = "";
                    int physicianID = 0;

                    // Process the results
                    while (rset.next()) {
                        healthCareID = rset.getInt("healthcareid");
                        firstName = rset.getString("firstname");
                        lastName = rset.getString("lastname");
                        city = rset.getString("city");
                        state = rset.getString("state");
                        birthDate = rset.getDate("birthdate");
                        bloodType = rset.getString("bloodtype");
                        physicianID = rset.getInt("physicianID");

                        System.out.println("Healthcare ID: " + healthCareID + "\nFirst Name: " + firstName + "\nLast Name: " + lastName +"\nCity: " + city + "\nState: " + state + "\nBirthdate: " + birthDate + "\nBlood Type: " + bloodType);
                    } // end while

                    rset.close();
                    stmt.close();
                    connection.close();
                    break;

                case 2:
                    System.out.println("Enter Primary Care Physician ID:");
                    int pcpID = reader.nextInt();
                    stmt = connection.createStatement();
                    str = "SELECT P.physicianID, P.specialty, P.medicalFacility, D.firstName, D.lastName FROM Doctor D join PCP P on P.physicianID=D.PHYSICIANID where D.PHYSICIANID=" + pcpID;
                    rset = stmt.executeQuery(str);

                    int docID = 0;
                    String pcpfName = "";
                    String pcplName = "";
                    String specialty = "";
                    String medicalFacility = "";

                    // Process the results
                    while (rset.next()) {
                        docID = rset.getInt("physicianid");
                        pcpfName = rset.getString("firstname");
                        pcplName = rset.getString("lastname");
                        specialty = rset.getString("specialty");
                        medicalFacility = rset.getString("medicalfacility");

                        System.out.println("Physician ID: " + docID + "\nFull Name: " + pcpfName + " " + pcplName + "\nSpecialty: " + specialty + "\nMedical Facility: " + medicalFacility);
                    } // end while

                    rset.close();
                    stmt.close();
                    connection.close();
                    break;
                case 3:
                    System.out.println("Enter Operation Invoice Number: ");
                    int operationID = reader.nextInt();
                    stmt = connection.createStatement();
                    str = "SELECT O.INVOICENUMBER, O.OPERATIONDATE, D.FIRSTNAME AS DFName, D.LASTNAME AS DLName, S.BOARDCERTIFIED, P.FIRSTNAME AS PFName, P.LASTNAME AS PLName, P.BLOODTYPE, P.CITY, P.STATE FROM Operation O JOIN Surgeon S on O.PHYSICIANID = S.PHYSICIANID JOIN Doctor D on D.physicianID = S.physicianID JOIN Patient P on P.HEALTHCAREID= O.HEALTHCAREID where O.invoiceNumber=" + operationID;
                    rset = stmt.executeQuery(str);

                    int opID = 0;
                    Date opDate = new Date();
                    String surgfName = "";
                    String surglName = "";
                    Boolean boardCertified = true;
                    String patfName = "";
                    String patlName = "";
                    String pBloodType = "";
                    String pcity = "";
                    String pstate = "";

                    // Process the results
                    while (rset.next()) {
                        opID = rset.getInt("invoiceNumber");
                        opDate = rset.getDate("operationDate");
                        surgfName = rset.getString("DFName");
                        surglName = rset.getString("DLName");
                        boardCertified = rset.getBoolean("boardCertified");
                        patfName = rset.getString("PFName");
                        patlName = rset.getString("PLName");
                        pBloodType = rset.getString("bloodType");
                        pcity = rset.getString("city");
                        pstate = rset.getString("state");

                        System.out.println("Invoice Number: " + opID + "\nOperation Date: " + opDate + "\nSurgeon Full Name: " + surgfName + " " + surglName + "\nBoard Certified?: " + boardCertified + "\nPatient Full Name: " + patfName + " " + patlName + "\nBlood Type: " + pBloodType + "\nCity: " + pcity + "\nState: " + pstate);
                    } // end while

                    rset.close();
                    stmt.close();
                    connection.close();
                    break;

                case 4:
                    System.out.println("Enter the Patient's Healthcare ID: ");
                    int pID = reader.nextInt();
                    System.out.println("Enter the Updated Blood Type: ");
                    String bType = reader.next();

                    stmt = connection.createStatement();
                    str = "UPDATE Patient set BLOODTYPE='" + bType + "' where healthcareID=" + pID;
                    rset = stmt.executeQuery(str);

                    rset.close();
                    stmt.close();
                    connection.close();
                    break;

                default:
                    break;

            }
        } catch (SQLException e) {
            System.out.println("Get Data Failed! Check output console");
            e.printStackTrace();
            return;
        }

    }

}

