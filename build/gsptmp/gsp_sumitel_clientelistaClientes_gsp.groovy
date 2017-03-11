import grails.plugins.metadata.GrailsPlugin
import org.grails.gsp.compiler.transform.LineNumber
import org.grails.gsp.GroovyPage
import org.grails.web.taglib.*
import org.grails.taglib.GrailsTagException
import org.springframework.web.util.*
import grails.util.GrailsUtil

class gsp_sumitel_clientelistaClientes_gsp extends GroovyPage {
public String getGroovyPageFileName() { "/WEB-INF/grails-app/views/cliente/listaClientes.gsp" }
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
invokeTag('set','g',7,['var':("entityName"),'value':(message(code: 'cliente.label', default: 'Cliente'))],-1)
printHtmlPart(4)
expressionOut.print(resource(dir: 'javascripts', file: 'underscore.js'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'javascripts', file: 'spin.js'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'javascripts', file: 'jquery.modal.js'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'javascripts', file: 'numeral.js'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'javascripts', file: 'accounting.min.js'))
printHtmlPart(6)
expressionOut.print(resource(dir: 'css', file: 'jsgrid.min.css'))
printHtmlPart(7)
expressionOut.print(resource(dir: 'css', file: 'jsgrid-theme.min.css'))
printHtmlPart(7)
expressionOut.print(resource(dir: 'css', file: 'ring.css'))
printHtmlPart(7)
expressionOut.print(resource(dir: 'css', file: 'jquery.modal.css'))
printHtmlPart(7)
expressionOut.print(resource(dir: 'css', file: 'bttn.min.css'))
printHtmlPart(7)
expressionOut.print(resource(dir: 'css', file: 'iziModal.min.css'))
printHtmlPart(8)
createTagBody(2, {->
createClosureForHtmlPart(9, 3)
invokeTag('captureTitle','sitemesh',23,[:],3)
})
invokeTag('wrapTitleTag','sitemesh',23,[:],2)
printHtmlPart(10)
expressionOut.print(createLink(controller: 'cliente', action: 'clientList'))
printHtmlPart(11)
expressionOut.print(createLink(controller: 'cliente', action: 'clientList'))
printHtmlPart(12)
expressionOut.print(createLink(controller:'cliente', action:'datosCliente'))
printHtmlPart(13)
expressionOut.print(createLink(controller: 'cliente', action: 'abonoCliente'))
printHtmlPart(14)
expressionOut.print(createLink(controller: 'cliente', action: 'listaClientes'))
printHtmlPart(15)
expressionOut.print(resource(dir: 'fonts', file: 'DK_High_Tea.otf'))
printHtmlPart(16)
})
invokeTag('captureHead','sitemesh',224,[:],1)
printHtmlPart(17)
createTagBody(1, {->
printHtmlPart(18)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.core.js'))
printHtmlPart(19)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.load-indicator.js'))
printHtmlPart(19)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.load-strategies.js'))
printHtmlPart(19)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.sort-strategies.js'))
printHtmlPart(19)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.field.js'))
printHtmlPart(20)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.text.js'))
printHtmlPart(19)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.number.js'))
printHtmlPart(19)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.select.js'))
printHtmlPart(19)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.checkbox.js'))
printHtmlPart(19)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.control.js'))
printHtmlPart(19)
expressionOut.print(resource(dir: 'javascripts', file: 'iziModal.js'))
printHtmlPart(21)
})
invokeTag('captureBody','sitemesh',266,[:],1)
printHtmlPart(22)
}
public static final Map JSP_TAGS = new HashMap()
protected void init() {
	this.jspTags = JSP_TAGS
}
public static final String CONTENT_TYPE = 'text/html;charset=UTF-8'
public static final long LAST_MODIFIED = 1489264469000L
public static final String EXPRESSION_CODEC = 'html'
public static final String STATIC_CODEC = 'none'
public static final String OUT_CODEC = 'none'
public static final String TAGLIB_CODEC = 'none'
}
