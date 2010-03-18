package uk.co.dubit.gaml.doc;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.TransformerFactoryConfigurationError;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.tools.ant.Task;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

public class BindingsDecomposer extends Task {
	
	private File bindings, output;
	
	public void execute() {

		try {
			final DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			final DocumentBuilder db = dbf.newDocumentBuilder();
			final Document doc = db.parse(bindings);
			final Element rootElement = doc.getDocumentElement();
			
			

			//Get any bindings that are not in a package
			final NodeList bindingList = rootElement.getElementsByTagName("Binding");
			final List<Node> bindings = new ArrayList<Node>(bindingList.getLength());
			for(int i = 0; i< bindingList.getLength(); i++) {
				final Element binding = (Element)bindingList.item(i);
				
				if(binding.getAttribute("nodoc") == "")
					bindings.add(binding);
			}
			
			//Get the package names and
			final NodeList packageList = rootElement.getElementsByTagName("Package");
			for(int i = 0; i< packageList.getLength(); i++) {
				final Element thisPackage = (Element) packageList.item(i);
				
				if(thisPackage.getAttribute("nodoc") != "")
					continue;
				
				final NodeList packageBindings = thisPackage.getElementsByTagName("Binding");
				for(int j = 0; j< packageBindings.getLength(); j++) {
					final Element packageBinding = (Element)packageBindings.item(j);
					packageBinding.setAttribute("package", thisPackage.getAttribute("name"));
					
					if(packageBinding.getAttribute("nodoc") == "")
						bindings.add(packageBinding);
				}
			}
			
			
			//Now output each node into a seperate file
			final Transformer transformer = TransformerFactory.newInstance().newTransformer();
			for(final Node bindingEl : bindings) {
				
				final String bindingName = bindingEl.getAttributes().getNamedItem("name").getNodeValue();
				
				final FileWriter writer = new FileWriter(new File(output, bindingName+".xml"));
				transformer.transform(new DOMSource(bindingEl), new StreamResult(writer));
				writer.close();	
			}
			
		}
		catch(final IOException e) {
			throw new IllegalArgumentException("Could not read file",e);
		} catch (ParserConfigurationException e) {
			throw new IllegalArgumentException("Could not read file",e);
		} catch (SAXException e) {
			throw new IllegalArgumentException("Could not read file",e);
		} catch (TransformerConfigurationException e) {
			throw new IllegalArgumentException("Could not write file",e);
		} catch (TransformerException e) {
			throw new IllegalArgumentException("Could not write file",e);
		} catch (TransformerFactoryConfigurationError e) {
			throw new IllegalArgumentException("Could not write file",e);
		}
	
	}
	
	public void setBindings(final String bindings) {
		this.bindings = new File(bindings);
	}
	
	public String getBindings() {
		return this.bindings.getAbsolutePath();
	}

	public void setOutput(final String output) {
		this.output = new File(output);
	}
	
	public String getOutput() {
		return output.getAbsolutePath();
	}
	
}
