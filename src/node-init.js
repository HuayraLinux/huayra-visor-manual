var initDispatched = false;

exports.onInit = function(cb) {
    if(!initDispatched) {
        /* No se pueden dar los argv desde acá porque los del process son distintos */
        cb();
        initDispatched = true;
    }
}