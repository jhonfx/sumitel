import grails.plugins.metadata.GrailsPlugin
import org.grails.gsp.compiler.transform.LineNumber
import org.grails.gsp.GroovyPage
import org.grails.web.taglib.*
import org.grails.taglib.GrailsTagException
import org.springframework.web.util.*
import grails.util.GrailsUtil

class gsp_sumitel_layoutsmain_gsp extends GroovyPage {
public String getGroovyPageFileName() { "/WEB-INF/grails-app/views/layouts/main.gsp" }
public Object run() {
Writer out = getOut()
Writer expressionOut = getExpressionOut()
registerSitemeshPreprocessMode()
printHtmlPart(0)

response.setHeader("Cache-Control","no-cache"); // Fuerza al cache a obtener una nueva copia de la pagina desde el servidor de origen
response.setHeader("Cache-Control","no-store"); // Indica al cache no guardar la pagina, bajo ninguna circunstancia
response.setDateHeader("Expires", 0);           // Causes the proxy cache to see the page as "stale"
response.setDateHeader('max-age', 0)
response.setIntHeader('Expires', -1)            //prevents caching at the proxy server
response.setHeader("Pragma", "no-cache");       // HTTP 1.0 compatibilidad

printHtmlPart(1)
createTagBody(1, {->
printHtmlPart(2)
invokeTag('captureMeta','sitemesh',12,['gsp_sm_xmlClosingForEmptyTag':("/"),'http-equiv':("Content-Type"),'content':("text/html; charset=UTF-8")],-1)
printHtmlPart(2)
invokeTag('captureMeta','sitemesh',13,['gsp_sm_xmlClosingForEmptyTag':("/"),'http-equiv':("X-UA-Compatible"),'content':("IE=edge")],-1)
printHtmlPart(2)
createTagBody(2, {->
createTagBody(3, {->
printHtmlPart(3)
invokeTag('layoutTitle','g',15,['default':("Grails")],-1)
printHtmlPart(2)
})
invokeTag('captureTitle','sitemesh',16,[:],3)
})
invokeTag('wrapTitleTag','sitemesh',16,[:],2)
printHtmlPart(2)
invokeTag('captureMeta','sitemesh',17,['gsp_sm_xmlClosingForEmptyTag':("/"),'name':("viewport"),'content':("width=device-width, initial-scale=1")],-1)
printHtmlPart(4)
expressionOut.print(resource(dir: 'javascripts', file: 'jquery-3.1.1.js'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'javascripts', file: 'jquery-ui.js'))
printHtmlPart(6)
expressionOut.print(resource(dir: 'css', file: 'jquery-ui.css'))
printHtmlPart(7)
expressionOut.print(resource(dir: 'css', file: 'jsgrid.min.css'))
printHtmlPart(7)
expressionOut.print(resource(dir: 'css', file: 'jsgrid-theme.min.css'))
printHtmlPart(7)
expressionOut.print(resource(dir: 'stylesheets', file: 'style_buttons.css'))
printHtmlPart(8)
expressionOut.print(resource(dir: 'javascripts', file: 'format_number.js'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'javascripts', file: 'sidebar.js'))
printHtmlPart(9)
expressionOut.print(resource(dir: 'css', file: 'push_nav.css'))
printHtmlPart(7)
expressionOut.print(resource(dir: 'css', file: 'ring.css'))
printHtmlPart(7)
expressionOut.print(resource(dir: 'css', file: 'sweetalert.css'))
printHtmlPart(7)
expressionOut.print(resource(dir: 'css', file: 'jquery.flexdatalist.css'))
printHtmlPart(8)
expressionOut.print(resource(dir: 'javascripts', file: 'sumitel_utils.js'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'javascripts', file: 'moment.js'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'javascripts', file: 'sweetalert.min.js'))
printHtmlPart(10)
invokeTag('stylesheet','asset',69,['src':("application.css")],-1)
printHtmlPart(2)
invokeTag('layoutHead','g',70,[:],-1)
printHtmlPart(11)
})
invokeTag('captureHead','sitemesh',71,[:],1)
printHtmlPart(11)
createTagBody(1, {->
printHtmlPart(12)
expressionOut.print(createLink(controller: 'almacen', action: 'listaalmacen'))
printHtmlPart(13)
expressionOut.print(createLink(controller: 'inventario', action: 'listarArticulos'))
printHtmlPart(14)
expressionOut.print(createLink(controller: 'almacen', action: 'altamasiva'))
printHtmlPart(15)
expressionOut.print(createLink(controller: 'almacen', action: 'altaporpistola'))
printHtmlPart(16)
expressionOut.print(createLink(controller: 'inventario', action: 'create'))
printHtmlPart(17)
expressionOut.print(createLink(controller: 'cliente', action: 'create'))
printHtmlPart(18)
expressionOut.print(createLink(controller: 'cliente', action: 'listaClientes'))
printHtmlPart(19)
expressionOut.print(createLink(controller: 'almacen', action: 'listaparaorden'))
printHtmlPart(20)
expressionOut.print(createLink(controller: 'ordenCompra', action: 'reimprimirOrden'))
printHtmlPart(21)
invokeTag('layoutBody','g',91,[:],-1)
printHtmlPart(22)
invokeTag('message','g',95,['code':("spinner.alt"),'default':("Loading&hellip;")],-1)
printHtmlPart(23)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.core.js'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.load-indicator.js'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.load-strategies.js'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.sort-strategies.js'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'javascripts', file: 'jsgrid.field.js'))
printHtmlPart(24)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.text.js'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.number.js'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.select.js'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.checkbox.js'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'javascripts', file: '/fields/jsgrid.field.control.js'))
printHtmlPart(24)
expressionOut.print(resource(dir: 'javascripts', file: 'jquery.flexdatalist.js'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'javascripts', file: 'underscore.js'))
printHtmlPart(25)
})
invokeTag('captureBody','sitemesh',114,[:],1)
printHtmlPart(26)
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
