import java.sql.*;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSetMetaData;
import java.sql.Statement;

import java.net.*;
import java.text.*;
import javax.naming.InitialContext;
import javax.naming.Context;
import javax.sql.DataSource;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.HashMap;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

public class DOMParser
{
  //No generics
  List xmlContent;
  Document dom;


  public DOMParser(){
    //create a list to hold the employee objects
    xmlContent = new ArrayList();
  }

  public void runParser() {
    
    parseXmlFile();
    parseDocument();
    
    // todo: replace this step with one that adds items to appropriate database
    //printData();
    
  }
  
  
  private void parseXmlFile(){
    //get the factory
    DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
    
    try {
      
      //Using factory get an instance of document builder
      DocumentBuilder db = dbf.newDocumentBuilder();
      
      //replace with desired XML e.g. actors63.xml
      dom = db.parse("actors63.xml");
      

    }catch(ParserConfigurationException pce) {
      pce.printStackTrace();
    }catch(SAXException se) {
      se.printStackTrace();
    }catch(IOException ioe) {
      ioe.printStackTrace();
    }
  }

  private void parseDocument(){
    Element docEle = dom.getDocumentElement();
    
    NodeList moviesList = docEle.getElementsByTagName("directorfilms");
    NodeList actorsList = docEle.getElementsByTagName("actor");
    NodeList castList = docEle.getElementsByTagName("filmc");
    if(moviesList != null && moviesList.getLength() > 0) {
      addToContentList(movieList);
    } else if (moviesList != null && moviesList.getLength() > 0) {
      addToContentList(actorsList);
    }
    else {
      addToContentList(castList);
    }
  }
  
  private void addToContentList(NodeList parentList) {
    for(int i = 0 ; i < parentList.getLength();i++) {   
      //get the employee element
      Element el = (Element)parentList.item(i);       
      //get the Employee object. TODO: replace with individual functions to "get" specific objects e.g. getActor or getFilm
      Employee e = getEmployee(el);       
      //add it to list
      xmlContent.add(e);
    }
  }
  
  // todo: instead of returning an "Employee" object, return a hashmap of the values to input
  // to the DB e.g. {"title": "Blade Runner", "year": "1982", "director" : "Ridley Scott"}
  private HashMap getMovie (Element el) {
    HashMap<String, String> movieObject = new HashMap<String, String>();
  }
  
  private Employee getEmployee(Element empEl) {
    
    //for each <employee> element get text or int values of 
    //name ,id, age and name
    String name = getTextValue(empEl,"Name");
    int id = getIntValue(empEl,"Id");
    int age = getIntValue(empEl,"Age");

    String type = empEl.getAttribute("type");
    
    //Create a new Employee with the value read from the xml nodes
    Employee e = new Employee(name,id,age,type);
    
    return e;
  }


  /**
   * I take a xml element and the tag name, look for the tag and get
   * the text content 
   * i.e for <employee><name>John</name></employee> xml snippet if
   * the Element points to employee node and tagName is name I will return John  
   * @param ele
   * @param tagName
   * @return
   */
  private String getTextValue(Element ele, String tagName) {
    String textVal = null;
    NodeList nl = ele.getElementsByTagName(tagName);
    if(nl != null && nl.getLength() > 0) {
      Element el = (Element)nl.item(0);
      textVal = el.getFirstChild().getNodeValue();
    }

    return textVal;
  }

  
  /**
   * Calls getTextValue and returns a int value
   * @param ele
   * @param tagName
   * @return
   */
  private int getIntValue(Element ele, String tagName) {
    //in production application you would catch the exception
    return Integer.parseInt(getTextValue(ele,tagName));
  }

  
  public static void main(String[] args){
    try {
      DOMParser dpe = new DOMParser();
      dpe.runParser();
    }
    catch (Exception e) {
      System.out.println(e);
    }
  }
}
