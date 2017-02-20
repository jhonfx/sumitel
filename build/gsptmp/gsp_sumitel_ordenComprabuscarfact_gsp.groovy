import sumitel.Cliente
import grails.plugins.metadata.GrailsPlugin
import org.grails.gsp.compiler.transform.LineNumber
import org.grails.gsp.GroovyPage
import org.grails.web.taglib.*
import org.grails.taglib.GrailsTagException
import org.springframework.web.util.*
import grails.util.GrailsUtil

class gsp_sumitel_ordenComprabuscarfact_gsp extends GroovyPage {
public String getGroovyPageFileName() { "/WEB-INF/grails-app/views/ordenCompra/buscarfact.gsp" }
public Object run() {
Writer out = getOut()
Writer expressionOut = getExpressionOut()
registerSitemeshPreprocessMode()
printHtmlPart(0)
createTagBody(1, {->
printHtmlPart(1)
invokeTag('captureMeta','sitemesh',5,['gsp_sm_xmlClosingForEmptyTag':("/"),'name':("layout"),'content':("main")],-1)
printHtmlPart(1)
invokeTag('set','g',6,['var':("entityName"),'value':(message(code: 'ordenCompra.label', default: 'OrdenCompra'))],-1)
printHtmlPart(2)
invokeTag('stylesheet','asset',8,['src':("application.css")],-1)
printHtmlPart(3)
expressionOut.print(resource(dir: 'javascripts', file: 'underscore.js'))
printHtmlPart(4)
expressionOut.print(resource(dir: 'javascripts', file: 'print.js'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'css', file: 'jsgrid.min.css'))
printHtmlPart(6)
expressionOut.print(resource(dir: 'css', file: 'jsgrid-theme.min.css'))
printHtmlPart(6)
expressionOut.print(resource(dir: 'css', file: 'print.css'))
printHtmlPart(6)
expressionOut.print(resource(dir: 'css', file: 'bttn.min.css'))
printHtmlPart(7)
createTagBody(2, {->
createClosureForHtmlPart(8, 3)
invokeTag('captureTitle','sitemesh',17,[:],3)
})
invokeTag('wrapTitleTag','sitemesh',17,[:],2)
printHtmlPart(9)
expressionOut.print(resource(dir: 'fonts', file: 'DK_High_Tea.otf'))
printHtmlPart(10)
expressionOut.print(createLink(controller: 'ordenCompra', action:'searchFactura'))
printHtmlPart(11)
expressionOut.print(createLink(controller: 'ordenCompra', action:'generarOrden'))
printHtmlPart(12)
expressionOut.print(createLink(controller: 'ordenCompra', action: 'printOrden'))
printHtmlPart(13)
expressionOut.print(createLink(controller: "ordenCompra", action:"searchClientInfo"))
printHtmlPart(14)
})
invokeTag('captureHead','sitemesh',280,[:],1)
printHtmlPart(1)
createTagBody(1, {->
printHtmlPart(15)
invokeTag('select','g',332,['name':("clientId"),'id':("client_name"),'class':("form-control col-sm-4"),'from':(Cliente.findAll()),'optionKey':("id"),'optionValue':("nombre"),'noSelection':(['':'Seleccione un cliente...'])],-1)
printHtmlPart(16)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.core.js'))
printHtmlPart(17)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.load-indicator.js'))
printHtmlPart(17)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.load-strategies.js'))
printHtmlPart(17)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.sort-strategies.js'))
printHtmlPart(17)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.field.js'))
printHtmlPart(18)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.text.js'))
printHtmlPart(17)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.number.js'))
printHtmlPart(17)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.select.js'))
printHtmlPart(17)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.checkbox.js'))
printHtmlPart(17)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.control.js'))
printHtmlPart(19)
})
invokeTag('captureBody','sitemesh',363,[:],1)
printHtmlPart(20)
}
public static final Map JSP_TAGS = new HashMap()
protected void init() {
	this.jspTags = JSP_TAGS
}
public static final String CONTENT_TYPE = 'text/html;charset=UTF-8'
public static final long LAST_MODIFIED = 1485582735000L
public static final String EXPRESSION_CODEC = 'html'
public static final String STATIC_CODEC = 'none'
public static final String OUT_CODEC = 'none'
public static final String TAGLIB_CODEC = 'none'
}
