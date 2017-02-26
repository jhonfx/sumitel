import grails.plugins.metadata.GrailsPlugin
import org.grails.gsp.compiler.transform.LineNumber
import org.grails.gsp.GroovyPage
import org.grails.web.taglib.*
import org.grails.taglib.GrailsTagException
import org.springframework.web.util.*
import grails.util.GrailsUtil

class gsp_sumitel_ordenCompraprintOrdenCompleta_gsp extends GroovyPage {
public String getGroovyPageFileName() { "/WEB-INF/grails-app/views/ordenCompra/printOrdenCompleta.gsp" }
public Object run() {
Writer out = getOut()
Writer expressionOut = getExpressionOut()
registerSitemeshPreprocessMode()
printHtmlPart(0)
createTagBody(1, {->
printHtmlPart(1)
createTagBody(2, {->
invokeTag('captureTitle','sitemesh',4,[:],-1)
})
invokeTag('wrapTitleTag','sitemesh',4,[:],2)
printHtmlPart(1)
invokeTag('captureMeta','sitemesh',5,['gsp_sm_xmlClosingForEmptyTag':(""),'charset':("UTF-8")],-1)
printHtmlPart(2)
expressionOut.print(resource(dir: 'css', file: 'style.css'))
printHtmlPart(3)
expressionOut.print(resource(dir: 'css', file: 'printer.css'))
printHtmlPart(3)
expressionOut.print(resource(dir: 'css', file: 'bootstrap.css'))
printHtmlPart(4)
expressionOut.print(resource(dir: 'javascripts', file: 'jquery-3.1.1.js'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'js', file: 'bootstrap.js'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'javascripts', file: 'moment.js'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'javascripts', file: 'moment-with-locales.js'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'javascripts', file: 'accounting.min.js'))
printHtmlPart(6)
expressionOut.print(createLink(controller: 'ordenCompra', action:'datosPrintOrdenCompleta'))
printHtmlPart(7)
})
invokeTag('captureHead','sitemesh',76,[:],1)
printHtmlPart(8)
createTagBody(1, {->
printHtmlPart(9)
invokeTag('img','g',87,['dir':("img"),'file':("sumitel.jpeg"),'class':("img-responsive sumitel")],-1)
printHtmlPart(10)
invokeTag('img','g',93,['dir':("img"),'file':("telcel.png"),'class':("img-responsive telcel")],-1)
printHtmlPart(11)
})
invokeTag('captureBody','sitemesh',160,[:],1)
printHtmlPart(12)
}
public static final Map JSP_TAGS = new HashMap()
protected void init() {
	this.jspTags = JSP_TAGS
}
public static final String CONTENT_TYPE = 'text/html;charset=UTF-8'
public static final long LAST_MODIFIED = 1487743787000L
public static final String EXPRESSION_CODEC = 'html'
public static final String STATIC_CODEC = 'none'
public static final String OUT_CODEC = 'none'
public static final String TAGLIB_CODEC = 'none'
}
