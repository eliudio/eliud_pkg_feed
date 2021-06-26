{
  "id": "Post",
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
    "isExtension": false,
    "isDocumentCollection": true
  },
  "memberIdentifier": "authorId",
  "fields": [
    {
      "fieldName": "documentID",
      "displayName": "Document ID",
      "fieldType": "String",
      "iconName": "vpn_key",
      "group": "general"
    },
    {
      "fieldName": "authorId",
      "displayName": "Author ID",
      "fieldType": "String",
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
      "fieldName": "feedId",
      "displayName": "Feed Identifier",
      "remark": "This is the identifier of the feed (optional as a post can also be used in an album)",
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
      "bespokeFieldType": "Map<String, dynamic>",
      "bespokeEntityMapping": "map['pageParameters']",
      "bespokeEntityToDocument" : "    theDocument['pageParameters'] = pageParameters;\n"
    },
    {
      "fieldName": "html",
      "displayName": "Rich Text",
      "fieldType": "String",
      "iconName": "text_format",
      "group": "general"
    },
    {
      "fieldName": "description",
      "displayName": "Description",
      "fieldType": "String",
      "iconName": "text_format",
      "group": "general"
    },
    {
      "fieldName": "likes",
      "displayName": "Likes",
      "fieldType": "int",
      "group": "general"
    },
    {
      "fieldName": "dislikes",
      "displayName": "Dislikes",
      "fieldType": "int",
      "group": "general"
    },
    {
      "fieldName": "readAccess",
      "displayName": "Members that can read this post. Array can contain 'PUBLIC'",
      "fieldType": "String",
      "iconName": "text_format",
      "arrayType": "Array",
      "hidden": true
    },
    {
      "fieldName": "archived",
      "fieldType": "enum",
      "defaultValue": "PostArchiveStatus.Active",
      "enumName": "PostArchiveStatus",
      "enumValues" : [ "Active", "Archived" ]
    },
    {
      "fieldName": "externalLink",
      "fieldType": "String",
      "group": "general"
    },
    {
      "fieldName": "memberMedia",
      "fieldType": "PostMedium",
      "displayName": "Media",
      "group": "media",
      "arrayType": "Array"
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
    },
    {
        "group": "media",
        "description": "Media"
    }
 ],
  "listFields": {
    "title": "timestamp.toString()",
    "subTitle": "documentID!"
  },
  "depends": ["eliud_core", "eliud_pkg_membership"]
}