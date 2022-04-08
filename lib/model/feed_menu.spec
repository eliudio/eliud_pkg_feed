{
  "id": "FeedMenu",
  "packageName": "eliud_pkg_feed",
  "isAppModel": true,
  "generate": {
    "generateComponent": true,
    "generateRepository": true,
    "generateCache": true,
	"hasPersistentRepository": true,
    "generateFirestoreRepository": true,
    "generateRepositorySingleton": true,
    "generateModel": true,
    "generateEntity": true,
    "generateForm": true,
    "generateList": true,
    "generateDropDownButton": true,
    "generateInternalComponent": true,
    "generateEmbeddedComponent": false,
    "isExtension": true,
    "documentSubCollectionOf": "app"
  },
  "fields": [
    {
      "fieldName": "documentID",
      "displayName": "Document ID",
      "fieldType": "String",
      "iconName": "vpn_key",
      "group": "general"
    },
    {
      "fieldName": "appId",
      "displayName": "App Identifier",
      "remark": "This is the identifier of the app to which this feed belongs",
      "fieldType": "String",
      "group": "general"
    },
    {
      "fieldName": "description",
      "displayName": "Description",
      "fieldType": "String",
      "group": "general"
    },
    {
      "fieldName": "bodyComponentsCurrentMemberLabels",
      "displayName": "Components Current Member",
      "fieldType": "String",
      "arrayType": "Array",
      "group": "components",
      "hidden": true
    },
    {
      "fieldName": "bodyComponentsCurrentMember",
      "displayName": "Components Current Member",
      "fieldType": "BodyComponent",
      "arrayType": "Array",
      "group": "components"
    },
    {
      "fieldName": "bodyComponentsOtherMemberLabels",
      "displayName": "Components Other Member",
      "fieldType": "String",
      "arrayType": "Array",
      "group": "components",
      "hidden": true
    },
    {
      "fieldName": "bodyComponentsOtherMember",
      "displayName": "Components Other Member",
      "fieldType": "BodyComponent",
      "arrayType": "Array",
      "group": "components"
    },
    {
      "fieldName": "itemColor",
      "displayName": "Item Color",
      "defaultValue": "RgbModel(r: 255, g: 255, b: 255, opacity: 1.00)",
      "fieldType": "Rgb",
      "group": "itemColors",
      "iconName": "color_lens",
      "bespokeFormField": "RgbField(widget.app, \"Text color\", state.value!.itemColor, _onItemColorChanged)"
    },
    {
      "fieldName": "selectedItemColor",
      "displayName": "Selected Item Color",
      "fieldType": "Rgb",
      "group": "itemColors",
      "iconName": "color_lens",
      "defaultValue": "RgbModel(r: 255, g: 255, b: 255, opacity: 1.00)",
      "bespokeFormField": "RgbField(widget.app, \"Selected Item Color\", state.value!.selectedItemColor, _onSelectedItemColorChanged)"
    },
    {
      "fieldName": "feedFront",
      "displayName": "Feed Front",
      "fieldType": "FeedFront",
      "association": true,
      "group": "general"
    },
    {
      "fieldName": "conditions",
      "displayName": "Conditions",
      "fieldType": "StorageConditions",
      "group": "conditions"
    }
  ],
  "groups": [
    {
        "group": "general",
        "description": "General"
    },
    {
        "group": "itemColors",
        "description": "Icon Colors"
    },
    {
        "group": "menuColors",
        "description": "Menu Colors"
    },
    {
        "group": "conditions",
        "description": "Conditions"
    }
 ],
  "listFields": {
    "title": "value.documentID != null ? Center(child: StyleRegistry.registry().styleWithApp(app).frontEndStyle().textStyle().text(app, context, value.documentID!)) : Container()",
    "subTitle": "value.description != null ? Center(child: StyleRegistry.registry().styleWithApp(app).frontEndStyle().textStyle().text(app, context, value.description!)) : Container()"
  },
  "depends": ["eliud_core"]
}