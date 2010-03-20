package uk.co.dubit.gaml.doc;

import java.io.IOException;
import java.io.StringWriter;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.TransformerFactoryConfigurationError;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import net.java.textilej.parser.MarkupParser;
import net.java.textilej.parser.builder.HtmlDocumentBuilder;
import net.java.textilej.parser.markup.textile.TextileDialect;

import org.apache.tools.ant.filters.StringInputStream;
import org.apache.xml.dtm.ref.DTMNodeIterator;
import org.w3c.dom.DOMException;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.Text;
import org.xml.sax.SAXException;

public class GamlExampleHandler {

	public static String parse_textile(final Object input) {
		
		final String textileInput;
		
		if(input instanceof DTMNodeIterator) {
			final DTMNodeIterator itr = (DTMNodeIterator)input;
			
			final StringBuilder builder = new StringBuilder();
			for(Node node = itr.nextNode(); node != null; node = itr.nextNode()) {
				builder.append(node.getNodeValue());
			}
			textileInput = builder.toString();
		}
		else {
			textileInput = input.toString();
		}
		
		final StringWriter output = new StringWriter();
		final HtmlDocumentBuilder htmlBuilder = new HtmlDocumentBuilder(output);
		
		final MarkupParser parser = new MarkupParser(new TextileDialect(), htmlBuilder);
		
		parser.parse(textileInput, false);
		
		return output.toString();
	}
	
	public static Object escape_code(final Object input) {
		final DTMNodeIterator itr = (DTMNodeIterator)input;
		
		final StringBuilder builder = new StringBuilder();
		for(Node node = itr.nextNode(); node != null; node = itr.nextNode()) {
			builder.append(node.getNodeValue());
		}
		
		try {
			final DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			final DocumentBuilder db = dbf.newDocumentBuilder();
			final Document doc = db.parse(new StringInputStream("<root>"+builder.toString()+"</root>"));
			
			final Transformer transformer = TransformerFactory.newInstance().newTransformer();
			transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
			
			final StringWriter writer = new StringWriter();
			final Element rootElement = doc.getDocumentElement();
			final NodeList children = rootElement.getChildNodes();
			
			for(int i = 0; i< children.getLength(); i++) {
				Node child = children.item(i);
				
				if(child instanceof Element) {
					
					final Element childElement = (Element)child;
					
					if(childElement.getTagName().equalsIgnoreCase("code")) {
						writer.append(formatExample(childElement));
						continue;
					}
				}
				else if(child instanceof Text) {
					final String htmlContent = parse_textile(child.getNodeValue());
					Node replacement = doc.importNode(db.parse(new StringInputStream("<div>"+htmlContent+"</div>")).getDocumentElement(), true);
					
					rootElement.replaceChild(replacement, child);
					child = replacement;
				}
				
				transformer.transform(new DOMSource(child), new StreamResult(writer));
			}
			
			return writer.toString();
			
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (DOMException e) {
			e.printStackTrace();
		} catch (TransformerFactoryConfigurationError e) {
			e.printStackTrace();
		} catch (TransformerConfigurationException e) {
			e.printStackTrace();
		} catch (TransformerException e) {
			e.printStackTrace();
		}
		
		return builder.toString();
	}

	private static String formatExample(Element element) throws TransformerFactoryConfigurationError, TransformerException {
		
		final NodeList children = element.getChildNodes();
		
		final Transformer transformer = TransformerFactory.newInstance().newTransformer();
		transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
		final StringWriter writer = new StringWriter();
		
		for(int i=0;i<children.getLength();i++) {
			
			transformer.transform(new DOMSource(children.item(i)), new StreamResult(writer));
			
		}
		
		return "<"+element.getNodeName()+">"+htmlEscape(writer.toString())+"</"+element.getNodeName()+"/>";
	}
	
	private static String htmlEscape(final String input) {
		return input.replace("<", "&lt;").replace(">", "&gt;");
	}
}
