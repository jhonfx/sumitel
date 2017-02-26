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
invokeTag('captureMeta','sitemesh',6,['gsp_sm_xmlClosingForEmptyTag':("/"),'name':("layout"),'content':("main")],-1)
printHtmlPart(2)
invokeTag('stylesheet','asset',7,['src':("application.css")],-1)
printHtmlPart(2)
invokeTag('set','g',8,['var':("entityName"),'value':(message(code: 'articulo.label', default: 'Articulo'))],-1)
printHtmlPart(3)
expressionOut.print(resource(dir: 'javascripts', file: 'underscore.js'))
printHtmlPart(4)
expressionOut.print(resource(dir: 'javascripts/utils', file: 'sumitel_utils.js'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'css', file: 'jsgrid.min.css'))
printHtmlPart(6)
expressionOut.print(resource(dir: 'css', file: 'jsgrid-theme.min.css'))
printHtmlPart(6)
expressionOut.print(resource(dir: 'css', file: 'bttn.min.css'))
printHtmlPart(7)
createTagBody(2, {->
createClosureForHtmlPart(8, 3)
invokeTag('captureTitle','sitemesh',19,[:],3)
})
invokeTag('wrapTitleTag','sitemesh',19,[:],2)
printHtmlPart(9)
expressionOut.print(resource(dir: 'fonts', file: 'DK_High_Tea.otf'))
printHtmlPart(10)
expressionOut.print(createLink(controller:"inventario", action:"infoProducto"))
printHtmlPart(11)
expressionOut.print(createLink(controller:'almacen', action:'saveData'))
printHtmlPart(12)
expressionOut.print(createLink(controller: 'inventario', action: 'listarArticulos'))
printHtmlPart(13)
})
invokeTag('captureHead','sitemesh',387,[:],1)
printHtmlPart(0)
createTagBody(1, {->
printHtmlPart(14)
for( inventarioList in (Inventario.findAll()) ) {
printHtmlPart(15)
expressionOut.print(inventarioList.id)
printHtmlPart(16)
expressionOut.print(inventarioList.articulo)
printHtmlPart(17)
}
printHtmlPart(18)
invokeTag('select','g',431,['name':("proveedorId"),'class':("form-control"),'from':(Proveedor.findAll()),'optionKey':("id"),'optionValue':("nombreProveedor"),'noSelection':(['':'Seleccione...'])],-1)
printHtmlPart(19)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.core.js'))
printHtmlPart(20)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.load-indicator.js'))
printHtmlPart(20)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.load-strategies.js'))
printHtmlPart(20)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.sort-strategies.js'))
printHtmlPart(20)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.field.js'))
printHtmlPart(21)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.text.js'))
printHtmlPart(20)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.number.js'))
printHtmlPart(20)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.select.js'))
printHtmlPart(20)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.checkbox.js'))
printHtmlPart(20)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.control.js'))
printHtmlPart(22)
})
invokeTag('captureBody','sitemesh',480,[:],1)
printHtmlPart(23)
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
