import grails.plugins.metadata.GrailsPlugin
import org.grails.gsp.compiler.transform.LineNumber
import org.grails.gsp.GroovyPage
import org.grails.web.taglib.*
import org.grails.taglib.GrailsTagException
import org.springframework.web.util.*
import grails.util.GrailsUtil

class gsp_sumitel_almacenlistaalmacen_gsp extends GroovyPage {
public String getGroovyPageFileName() { "/WEB-INF/grails-app/views/almacen/listaalmacen.gsp" }
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
printHtmlPart(1)
invokeTag('set','g',6,['var':("entityName"),'value':(message(code: 'articulo.label', default: 'ListaAlmacen'))],-1)
printHtmlPart(2)
expressionOut.print(resource(dir: 'javascripts', file: 'underscore.js'))
printHtmlPart(3)
expressionOut.print(resource(dir: 'javascripts', file: 'spin.js'))
printHtmlPart(3)
expressionOut.print(resource(dir: 'javascripts', file: 'jquery.modal.js'))
printHtmlPart(3)
expressionOut.print(resource(dir: 'javascripts', file: 'accounting.min.js'))
printHtmlPart(4)
expressionOut.print(resource(dir: 'css', file: 'jsgrid.min.css'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'css', file: 'jsgrid-theme.min.css'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'css', file: 'ring.css'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'css', file: 'jquery.modal.css'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'css', file: 'bttn.min.css'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'css', file: 'iziModal.min.css'))
printHtmlPart(6)
createTagBody(2, {->
createClosureForHtmlPart(7, 3)
invokeTag('captureTitle','sitemesh',21,[:],3)
})
invokeTag('wrapTitleTag','sitemesh',21,[:],2)
printHtmlPart(8)
expressionOut.print(resource(dir: 'fonts', file: 'DK_High_Tea.otf'))
printHtmlPart(9)
expressionOut.print(createLink(controller: 'almacen', action:'obtenerAlmacen'))
printHtmlPart(10)
expressionOut.print(createLink(controller: 'almacen', action: 'deleteProducto'))
printHtmlPart(11)
})
invokeTag('captureHead','sitemesh',267,[:],1)
printHtmlPart(12)
createTagBody(1, {->
printHtmlPart(13)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.core.js'))
printHtmlPart(14)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.load-indicator.js'))
printHtmlPart(14)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.load-strategies.js'))
printHtmlPart(14)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.sort-strategies.js'))
printHtmlPart(14)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.field.js'))
printHtmlPart(15)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.text.js'))
printHtmlPart(14)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.number.js'))
printHtmlPart(14)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.select.js'))
printHtmlPart(14)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.checkbox.js'))
printHtmlPart(14)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.control.js'))
printHtmlPart(16)
})
invokeTag('captureBody','sitemesh',295,[:],1)
printHtmlPart(17)
}
public static final Map JSP_TAGS = new HashMap()
protected void init() {
	this.jspTags = JSP_TAGS
}
public static final String CONTENT_TYPE = 'text/html;charset=UTF-8'
public static final long LAST_MODIFIED = 1496742923000L
public static final String EXPRESSION_CODEC = 'html'
public static final String STATIC_CODEC = 'none'
public static final String OUT_CODEC = 'none'
public static final String TAGLIB_CODEC = 'none'
}
