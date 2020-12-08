{
  "id": "Post",
  "packageName": "eliud_pkg_feed",
  "isAppModel": true,
  "generate": {
    "generateComponent": true,
    "generateRepository": true,
    "generateCache": true,
	"hasPersistentRepository": true,
    "generateFirestoreRepository": false,
    "generateModel": true,
    "generateEntity": true,
    "generateForm": true,
    "generateList": true,
    "generateDropDownButton": true,
    "generateInternalComponent": true,
    "generateEmbeddedComponent": false,
    "isExtension": false
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
      "fieldName": "author",
      "displayName": "Author",
      "fieldType": "Member",
      "association": true,
      "group": "member"
    },
    {
      "fieldName": "timestamp",
      "displayName": "Timestamp",
      "fieldType": "ServerTimestamp",
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
      "fieldName": "postAppId",
      "displayName": "Post App Identifier",
      "remark": "This is the identifier of the app to where this feed points to",
      "fieldType": "String",
      "iconName": "text_format",
      "group": "general"
    },
    {
      "fieldName": "postPageId",
      "displayName": "Post Page Identifier",
      "remark": "This is the identifier of the page to where this feed points to",
      "fieldType": "String",
      "iconName": "text_format",
      "group": "general"
    },
    {
      "fieldName": "pageParameters",
      "fieldType": "bespoke",
      "bespokeFieldType": "Map<String, Object>",
      "bespokeEntityMapping": "map['pageParameters']",
      "bespokeEntityToDocument" : "    theDocument['pageParameters'] = pageParameters;\n"
    },
    {
      "fieldName": "description",
      "displayName": "Description",
      "fieldType": "String",
      "iconName": "text_format",
      "group": "general"
    },
    {
      "fieldName": "readAccess",
      "displayName": "Members that can read this post. Array can contain 'public'",
      "fieldType": "String",
      "iconName": "text_format",
      "arrayType": "Array",
      "hidden": true
    }
  ],
  "groups": [
    {
        "group": "general",
        "description": "General"
    },
    {
        "group": "member",
        "description": "Member"
    }
 ],
  "listFields": {
    "title": "timestamp.toString()",
    "subTitle": "documentID"
  },
  "depends": ["eliud_core"]
}