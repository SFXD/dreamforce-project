({  
    // Load current profile picture
    onInit: function(component) {
        var action = component.get("c.getUserProfilePhotoUrl");
        action.setParams({
            parentId: component.get("v.userId"),
        });
        action.setCallback(this, function(a) {
            var photoUrl = a.getReturnValue();
            console.log(photoUrl);
            if (photoUrl) {
	            component.set('v.pictureSrc', photoUrl);
            }
        });
        $A.enqueueAction(action);
    },
    
    onDragOver: function(component, event) {
        event.preventDefault();
    },

    onDrop: function(component, event, helper) {
		event.stopPropagation();
        event.preventDefault();
        event.dataTransfer.dropEffect = 'copy';
        var files = event.dataTransfer.files;
        if (files.length>1) {
            return alert("You can only upload one profile picture");
        }
        helper.readFile(component, helper, files[0]);
	}
    
})