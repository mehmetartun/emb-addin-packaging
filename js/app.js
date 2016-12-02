// Foundation JavaScript
// Documentation can be found at: http://foundation.zurb.com/docs
$(document).foundation();



$(document).ready(function(){
	alert('document ready');
    fin.desktop.main(function(){
		alert('inside fin main');
		var Excel = fin.desktop.Excel;
		Excel.init();
        installAddIn();
    });
	

});

    function installAddIn() {
		alert('trying to launch');
        fin.desktop.System.launchExternalProcess({
            path: 'emb-addin-packaging',
            target: 'InstallAddIn.vbs',
            listener: function (args) {
				
                console.log('Installer script completed!');

                if (args.exitCode == 0) {
                    fin.desktop.System.launchExternalProcess({
                        target: '%localappdata%\\OpenFin\\shared\\assets\\emb-addin-packaging\\EMBonds_64.xll'
                    });
                }
            }
        });
    }



