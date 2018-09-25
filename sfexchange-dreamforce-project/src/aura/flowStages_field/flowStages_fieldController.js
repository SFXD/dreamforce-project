({
    init : function(component, event, helper) {
        let progressIndicator = component.find('progressIndicator');
        for (let step of component.get('v.stages')) {
            console.log(step);
            $A.createComponent("lightning:progressStep", {
                "aura:id": "step_" + step,
                "label": step,
                "value": step
            },
                function(newProgressStep, status, errorMessage) {
                    // Add the new step to the progress array
                    if (status === "SUCCESS") {
                        let body = progressIndicator.get("v.body");
                        body.push(newProgressStep);
                        progressIndicator.set("v.body", body);
                    } else if (status === "INCOMPLETE") {
                        // Show offline error
                        console.log("No response from server, or client is offline.")
                    } else if (status === "ERROR") {
                        // Show error message
                        console.log("Error: " + errorMessage);
                    }
                }
            );
        }
    }
})