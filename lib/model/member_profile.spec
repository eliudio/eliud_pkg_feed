{
  "id": "MemberProfile",
  "packageName": "eliud_pkg_feed",
  "isAppModel": true,
  "generate": {
    "generateComponent": false,
    "generateRepository": true,
    "generateCache": false,
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
    "documentSubCollectionOf": "app"
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
      "fieldName": "appId",
      "displayName": "App ID",
      "fieldType": "String",
      "iconName": "vpn_key",
      "hidden": true,
      "group": "general"
    },
    {
      "fieldName": "feedId",
      "displayName": "Feed Identifier",
      "remark": "This is the identifier of the feed",
      "fieldType": "String",
      "group": "general"
    },
    {
      "fieldName": "authorId",
      "displayName": "Author ID",
      "fieldType": "String",
      "group": "member"
    },
    {
      "fieldName": "profile",
      "displayName": "Profile",
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
      "displayName": "Profile Override",
      "fieldType": "String",
      "group": "image"
    },
    {
      "fieldName": "nameOverride",
      "displayName": "Name override",
      "fieldType": "String",
      "group": "general"
    },
    {
      "fieldName": "accessibleByGroup",
      "fieldType": "enum",
      "enumName": "MemberProfileAccessibleByGroup",
      "enumValues" : [ "Public", "Followers", "Me", "SpecificMembers" ]
    },
    {
      "fieldName": "accessibleByMembers",
      "remark": "In case accessibleByGroup == SpecificMembers, then these are the members",
      "displayName": "Accessible By Members",
      "fieldType": "String",
      "iconName": "text_format",
      "arrayType": "Array",
      "hidden": true
    },
    {
      "fieldName": "readAccess",
      "displayName": "Members that can read this detail of the chat. This is determined in functions, based on accessibleByGroup and accessibleByMembers",
      "fieldType": "String",
      "iconName": "text_format",
      "arrayType": "Array",
      "hidden": true
    },
    {
      "fieldName": "memberMedia",
      "fieldType": "MemberMediumContainer",
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
        "group": "imageSource",
        "description": "Source"
    },
    {
        "group": "filename",
        "description": "Photo"
    }
  ],
  "listFields": {
    "title": "value.documentID != null ? Center(child: StyleRegistry.registry().styleWithApp(app).frontEndStyle().textStyle().text(app, context, value.documentID!)) : Container()"
  },
  "depends": ["eliud_core"]
}
