{
  "id": "Feed",
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
      "fieldName": "thumbImage",
      "displayName": "Thumbs Image",
      "fieldType": "enum",
      "enumName": "ThumbStyle",
      "enumValues" : [ "Thumbs", "Banana" ]
    },
    {
      "fieldName": "photoPost",
      "displayName": "Photo Post",
      "remark": "Allow photo posts",
      "fieldType": "bool"
    },
    {
      "fieldName": "videoPost",
      "displayName": "Video Post",
      "remark": "Allow video posts",
      "fieldType": "bool"
    },
    {
      "fieldName": "messagePost",
      "displayName": "Message Post",
      "remark": "Allow message posts",
      "fieldType": "bool"
    },
    {
      "fieldName": "audioPost",
      "displayName": "Audio Post",
      "remark": "Allow audio posts",
      "fieldType": "bool"
    },
    {
      "fieldName": "albumPost",
      "displayName": "Album Post",
      "remark": "Allow album posts",
      "fieldType": "bool"
    },
    {
      "fieldName": "articlePost",
      "displayName": "Article Post",
      "remark": "Allow article posts",
      "fieldType": "bool"
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
        "group": "conditions",
        "description": "Conditions"
    }
 ],
  "listFields": {
    "title": "documentID!",
    "subTitle": "description!"
  },
  "depends": ["eliud_core"]
}