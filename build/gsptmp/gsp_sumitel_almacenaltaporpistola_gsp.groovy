import sumitel.Almacen
import sumitel.Proveedor
import sumitel.Inventario
import grails.plugins.metadata.GrailsPlugin
import org.grails.gsp.compiler.transform.LineNumber
import org.grails.gsp.GroovyPage
import org.grails.web.taglib.*
import org.grails.taglib.GrailsTagException
import org.springframework.web.util.*
import grails.util.GrailsUtil

class gsp_sumitel_almacenaltaporpistola_gsp extends GroovyPage {
public String getGroovyPageFileName() { "/WEB-INF/grails-app/views/almacen/altaporpistola.gsp" }
public Object run() {
Writer out = getOut()
Writer expressionOut = getExpressionOut()
registerSitemeshPreprocessMode()
printHtmlPart(0)
printHtmlPart(0)
printHtmlPart(1)
createTagBody(1, {->
printHtmlPart(2)
invokeTag('captureMeta','sitemesh',7,['gsp_sm_xmlClosingForEmptyTag':("/"),'name':("layout"),'content':("main")],-1)
printHtmlPart(2)
invokeTag('stylesheet','asset',8,['src':("application.css")],-1)
printHtmlPart(2)
invokeTag('set','g',9,['var':("entityName"),'value':(message(code: 'articulo.label', default: 'Articulo'))],-1)
printHtmlPart(3)
expressionOut.print(resource(dir: 'javascripts', file: 'jquery-1.8.3.js'))
printHtmlPart(4)
expressionOut.print(resource(dir: 'javascripts', file: 'underscore.js'))
printHtmlPart(4)
expressionOut.print(resource(dir: 'javascripts/utils', file: 'sumitel_utils.js'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'css', file: 'jsgrid.min.css'))
printHtmlPart(6)
expressionOut.print(resource(dir: 'css', file: 'jsgrid-theme.min.css'))
printHtmlPart(7)
createTagBody(2, {->
createClosureForHtmlPart(8, 3)
invokeTag('captureTitle','sitemesh',19,[:],3)
})
invokeTag('wrapTitleTag','sitemesh',19,[:],2)
printHtmlPart(9)
expressionOut.print(createLink(controller:"inventario", action:"infoProducto"))
printHtmlPart(10)
expressionOut.print(createLink(controller:'almacen', action:'saveData'))
printHtmlPart(11)
expressionOut.print(createLink(controller: 'almacen', action: 'listaAlmacen'))
printHtmlPart(12)
})
invokeTag('captureHead','sitemesh',205,[:],1)
printHtmlPart(0)
createTagBody(1, {->
printHtmlPart(13)
invokeTag('select','g',226,['name':("inventarioId"),'class':("form-control col-md-4"),'id':("inventarioId"),'from':(Inventario.findAll()),'optionKey':("id"),'optionValue':("articulo"),'noSelection':(['':'Seleccione...'])],-1)
printHtmlPart(14)
invokeTag('select','g',238,['name':("proveedorId"),'class':("form-control"),'from':(Proveedor.findAll()),'optionKey':("id"),'optionValue':("nombreProveedor"),'noSelection':(['':'Seleccione...'])],-1)
printHtmlPart(15)
expressionOut.print(name)
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
invokeTag('captureBody','sitemesh',291,[:],1)
printHtmlPart(20)
}
public static final Map JSP_TAGS = new HashMap()
protected void init() {
	this.jspTags = JSP_TAGS
}
public static final String CONTENT_TYPE = 'text/html;charset=UTF-8'
public static final long LAST_MODIFIED = 1472426829000L
public static final String EXPRESSION_CODEC = 'html'
public static final String STATIC_CODEC = 'none'
public static final String OUT_CODEC = 'none'
public static final String TAGLIB_CODEC = 'none'
}
