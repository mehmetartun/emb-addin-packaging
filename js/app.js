// Foundation JavaScript
// Documentation can be found at: http://foundation.zurb.com/docs

$(document).ready(function(){
    fin.desktop.main(function(){
        //installAddIn();
    });
});
$("#installbutton").click(function(){
    fin.desktop.main(function(){
		installAddIn();
    });
});
$("#openfininstallbutton").click(function(){
    fin.desktop.main(function(){
		installOpenfinAddIn();
    });
});
$("#launchembondspricer").click(function(){
    fin.desktop.main(function(){
		launchEMBondsPricer();
    });
});




function installAddIn() {
    fin.desktop.System.launchExternalProcess({
        alias: 'embonds-addin',
        target: 'InstallAddIn.vbs',
        listener: function (args) {
            console.log('Installer script completed!');
			console.log(args);

        }
    });
}

function installOpenfinAddIn() {
    fin.desktop.System.launchExternalProcess({
        alias: 'embonds-addin',
        target: 'InstallOpenfinAddIn.vbs',
        listener: function (args) {
            console.log('Installer script completed!');
			console.log(args);

        }
    });
}


function launchEMBondsPricer(){
                fin.desktop.System.launchExternalProcess({
                    alias: "embonds-addin",
                    target: "TR-Eurobonds-Enable-Macros.xlsm",
                    listener: function(code) {
                            console.log('the exit code', code);
                        }
                    },
                    function() {
                        console.log('Excel launched');
                    },
                    function(){
                        console.log('Error in launching Excel');
                    });

				}
