/**
 * User: Mario A. Pineda Pineda
 * Date: 7/28/11
 */
//Funcion que recorta un numero a 2 decimales
$(document).ready(function() {
    $.fn.decimals = function() {
        return this.each(function() {
            if (this.value) {
                if (isNaN(parseFloat(this.value))) return;
                this.value = parseFloat(this.value).toFixed(2);
            } else if (this.innerHTML) {
                if (isNaN(parseFloat(this.innerHTML))) return;
                this.innerHTML = parseFloat(this.innerHTML).toFixed(2);
            }
        });
    }
    /**
     * Metodo que serializa una forma en un objeto json
     */
    $.fn.serializeObject = function() {
        var o = {};
        var a = this.serializeArray();
        $.each(a, function() {
            if (o[this.name] !== undefined) {
                if (!o[this.name].push) {
                    o[this.name] = [o[this.name]];
                }
                o[this.name].push(this.value || '');
            } else {
                o[this.name] = this.value || '';
            }
        });
        return o;
    };

    /**
     * <p>Returns true if the passed value is empty.</p>
     * <p>The value is deemed to be empty if it is<div class="mdetail-params"><ul>
     * <li>null</li>
     * <li>undefined</li>
     * <li>an empty array</li>
     * <li>a zero length string (Unless the <tt>allowBlank</tt> parameter is <tt>true</tt>)</li>
     * </ul></div>
     * @param {Mixed} value The value to test
     * @param {Boolean} allowBlank (optional) true to allow empty strings (defaults to false)
     * @return {Boolean}
     */
    $.fn.isEmpty = function(v, allowBlank) {
        return v == null || v == undefined || (!allowBlank ? v == '' : false);
    };
    /**
     * Funcion que valida que una fecha sea del formato valido dd/mm/YYYY
     * y que sus valores realmente correspondan a una fecha.
     * @param fecha
     */
    $.fn.validarFecha = function(fecha) {
        var DATE_REGEX = /^(\d{1,2})\/(\d{1,2})\/(\d{4})$/;
        if (!DATE_REGEX.test(fecha)) {
            return false;
        }

        var dia = parseInt(fecha.substring(0, 2), 10);
        var mes = parseInt(fecha.substring(3, 5), 10);

        if (dia < 1 || dia > 31 || mes < 1 || mes > 12) {
            return false;
        }

        var anio = parseInt(fecha.substring(6), 10);

        if (mes == 2) {
            if ($.fn.esBisiesto(anio)) {
                return !(dia > 29);
            }
            else {
                return !(dia > 28);
            }
        }
        else if (mes == 4 || mes == 6 || mes == 9 || mes == 11) {
            return !(dia > 30);
        }
        return true;
    };

    $.fn.esBisiesto = function (anio) {
        //console.log('verificando si es bisiesto!');
        var BISIESTO;
        if (parseInt(anio, 10) % 4 == 0) {
            if (parseInt(anio, 10) % 100 == 0) {
                if (parseInt(anio, 10) % 400 == 0) {
                    BISIESTO = true;
                }
                else {
                    BISIESTO = false;
                }
            }
            else {
                BISIESTO = true;
            }
        }
        else
            BISIESTO = false;
        return BISIESTO;
    };

});

//Funciones que permite solo la escritura de numeros decimales
function numbersOnly(e) {
    var key;
    var keychar;

    if (window.event) {
        key = window.event.keyCode;
    }
    else if (e) {
        key = e.which;
    }
    else {
        return true;
    }
    keychar = String.fromCharCode(key);

    if ((key == null) || (key == 0) || (key == 8) || (key == 9) || (key == 13) || (key == 27)) {
        return true;
    }
    else if ((("0123456789").indexOf(keychar) > -1)) {
        return true;
    }
    else if (( !(/\./g.test(getTarget(e).value)) ) && (keychar == ".")) {
        return true;
    }
    else {
        return false;
    }
}
function getTarget(e) {
    var targ;
    if (!e) var e = window.event;
    if (e.target) targ = e.target;
    else if (e.srcElement) targ = e.srcElement;
    if (targ.nodeType == 3) // defeat Safari bug
        targ = targ.parentNode;
    return targ;
}

//Limita el tama&ntilde;o de un campo con decimales
function limitLengthWithDecimals(obj, tamanio, decimales) {
    var value = obj.value
    var maxIntegers = parseInt(tamanio);
    var maxDecimals = parseInt(decimales);

    if (value.indexOf('.') > -1) {
        var numeroPartes = value.split('.');

        if (numeroPartes.length > 0) {
            var parteEntera = numeroPartes[0].substring(0, maxIntegers);
            var decimales = '.';
            if (!isNaN(numeroPartes[1])) {
                decimales = decimales + numeroPartes[1].substring(0, maxDecimals);
            }
            obj.value = parteEntera + decimales
        }
    } else {
        obj.value = value.substring(0, maxIntegers);
    }
}

//Limita el tama&ntilde;o de un campo
function limitLengthInput(obj, tamanio) {
    var value = obj.value
    var maxIntegers = parseInt(tamanio);

    if (value.indexOf('.') > -1) {
        var numeroPartes = value.split('.');

        if (numeroPartes.length > 0) {
            var parteEntera = numeroPartes[0].substring(0, maxIntegers);
            obj.value = parteEntera
        }
    } else {
        obj.value = value.substring(0, maxIntegers);
    }
}

/**
 *Funcion para reemplazar esos caracteres extraños en los montos
 * @param value
 */
function replaceCaracteres(value) {
    value = value.replace(",", "")
    value = value.replace("$", "")
    return value
}

/**
 * Funcion que reemplaza todos los caracteres encontrados en una cadena
 * @param text
 * @param busca
 * @param reemplaza
 */
function replaceAll(text, busca, reemplaza) {
    while (text.toString().indexOf(busca) != -1)
        text = text.toString().replace(busca, reemplaza);
    return text;
}

/**
 * Funcion que valida si el keyCode (que puede venir de un event) se trata de una
 * tecla numerica (tanto del teclado numero como de las teclas de numeros normales)
 */
function isKeyCodeANumbericKey(keyCode) {
    return (keyCode >= 48 && keyCode <= 57) || (keyCode >= 96 && keyCode <= 105);
}


