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
    "isDocumentCollection": true
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
      "fieldName": "menu",
      "displayName": "Menu",
      "fieldType": "MenuDef",
      "association": true,
      "optional": true,
      "group": "iconMenu"
    },
    {
      "fieldName": "itemColor",
      "displayName": "Item Color",
      "defaultValue": "RgbModel(r: 255, g: 255, b: 255, opacity: 1.00)",
      "fieldType": "Rgb",
      "group": "itemColors",
      "iconName": "color_lens",
      "bespokeFormField": "RgbField(\"Text color\", state.value!.itemColor, _onItemColorChanged)"
    },
    {
      "fieldName": "selectedItemColor",
      "displayName": "Selected Item Color",
      "fieldType": "Rgb",
      "group": "itemColors",
      "iconName": "color_lens",
      "defaultValue": "RgbModel(r: 255, g: 255, b: 255, opacity: 1.00)",
      "bespokeFormField": "RgbField(\"Selected Item Color\", state.value!.selectedItemColor, _onSelectedItemColorChanged)"
    },
    {
      "fieldName": "conditions",
      "displayName": "Conditions",
      "fieldType": "ConditionsSimple",
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
    "title": "documentID",
    "subTitle": "description"
  },
  "depends": ["eliud_core"]
}