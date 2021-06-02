{
  "id": "MemberProfile",
  "packageName": "eliud_pkg_feed",
  "isAppModel": true,
  "generate": {
    "generateComponent": false,
    "generateRepository": true,
    "generateCache": true,
    "hasPersistentRepository": true,
    "generateFirestoreRepository": true,
    "generateRepositorySingleton": true,
    "generateModel": true,
    "generateEntity": true,
    "generateForm": true,
    "generateList": true,
    "generateDropDownButton": false,
    "generateInternalComponent": false,
    "generateEmbeddedComponent": true,
    "isDocumentCollection": true
  },
  "memberIdentifier": "documentID",
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
      "displayName": "App ID",
      "fieldType": "String",
      "iconName": "vpn_key",
      "hidden": true,
      "group": "general"
    },
    {
      "fieldName": "profile",
      "displayName": "App ID",
      "fieldType": "String",
      "group": "general"
    },
    {
      "fieldName": "profileBackground",
      "displayName": "Image",
      "fieldType": "MemberMedium",
      "association": true,
      "group": "image",
      "optional": true
    },
    {
      "fieldName": "profileOverride",
      "displayName": "Image",
      "fieldType": "MemberMedium",
      "association": true,
      "group": "image",
      "optional": true
    },
    {
      "fieldName": "readAccess",
      "displayName": "Members that can read this profile. Array can contain 'PUBLIC'",
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
        "group": "imageSource",
        "description": "Source"
    },
    {
        "group": "filename",
        "description": "Photo"
    }
  ],
  "listFields": {
    "title": "documentID",
    "subTitle": "documentID"
  },
  "depends": ["eliud_core"]
}
