import grails.plugins.metadata.GrailsPlugin
import org.grails.gsp.compiler.transform.LineNumber
import org.grails.gsp.GroovyPage
import org.grails.web.taglib.*
import org.grails.taglib.GrailsTagException
import org.springframework.web.util.*
import grails.util.GrailsUtil

class gsp_sumitel_inventariocreate_gsp extends GroovyPage {
public String getGroovyPageFileName() { "/WEB-INF/grails-app/views/inventario/create.gsp" }
public Object run() {
Writer out = getOut()
Writer expressionOut = getExpressionOut()
registerSitemeshPreprocessMode()
printHtmlPart(0)
createTagBody(1, {->
printHtmlPart(1)
invokeTag('captureMeta','sitemesh',4,['gsp_sm_xmlClosingForEmptyTag':("/"),'name':("layout"),'content':("main")],-1)
printHtmlPart(1)
invokeTag('stylesheet','asset',5,['src':("application.css")],-1)
printHtmlPart(2)
expressionOut.print(resource(dir: 'css', file: 'bttn.min.css'))
printHtmlPart(3)
invokeTag('set','g',7,['var':("entityName"),'value':(message(code: 'articulo.label', default: 'Inventario'))],-1)
printHtmlPart(1)
createTagBody(2, {->
createClosureForHtmlPart(4, 3)
invokeTag('captureTitle','sitemesh',8,[:],3)
})
invokeTag('wrapTitleTag','sitemesh',8,[:],2)
printHtmlPart(5)
expressionOut.print(resource(dir: 'fonts', file: 'DK_High_Tea.otf'))
printHtmlPart(6)
})
invokeTag('captureHead','sitemesh',103,[:],1)
printHtmlPart(7)
createTagBody(1, {->
printHtmlPart(8)
createTagBody(2, {->
printHtmlPart(9)
invokeTag('radio','g',143,['name':("tipo"),'value':("1")],-1)
printHtmlPart(10)
invokeTag('radio','g',144,['name':("tipo"),'value':("2")],-1)
printHtmlPart(11)
})
invokeTag('form','g',153,['id':("form_article"),'class':("form-horizontal"),'controller':("inventario"),'action':("saveArticle")],2)
printHtmlPart(12)
expressionOut.print(resource(dir: 'javascripts', file: 'format_number.js'))
printHtmlPart(13)
})
invokeTag('captureBody','sitemesh',158,[:],1)
printHtmlPart(14)
}
public static final Map JSP_TAGS = new HashMap()
protected void init() {
	this.jspTags = JSP_TAGS
}
public static final String CONTENT_TYPE = 'text/html;charset=UTF-8'
public static final long LAST_MODIFIED = 1484429285000L
public static final String EXPRESSION_CODEC = 'html'
public static final String STATIC_CODEC = 'none'
public static final String OUT_CODEC = 'none'
public static final String TAGLIB_CODEC = 'none'
}
