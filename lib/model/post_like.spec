{
  "id": "PostLike",
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
    "documentSubCollectionOf": "app"
  },
  "memberIdentifier": "memberId",
  "fields": [
    {
      "fieldName": "documentID",
      "displayName": "Document ID",
      "fieldType": "String",
      "iconName": "vpn_key",
      "group": "general"
    },
    {
      "fieldName": "postId",
      "displayName": "Document ID of the post",
      "fieldType": "String",
      "iconName": "vpn_key",
      "group": "general"
    },
    {
      "fieldName": "postCommentId",
      "displayName": "Document ID of the comment (in case of a like on a comment)",
      "fieldType": "String",
      "iconName": "vpn_key",
      "group": "general"
    },
    {
      "fieldName": "memberId",
      "displayName": "Member",
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
      "fieldName": "likeType",
      "displayName": "How do you like this?",
      "fieldType": "enum",
      "enumName": "LikeType",
      "enumValues" : [ "Like", "Dislike" ]
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
    "title": "value!.timestamp != null ? Center(child: StyleRegistry.registry().styleWithContext(context).adminListStyle().listItem(context, value!.timestamp!.toString())) : Container()",
    "subTitle": "value!.documentID != null ? Center(child: StyleRegistry.registry().styleWithContext(context).adminListStyle().listItem(context, value!.documentID!)) : Container()"
  },
  "depends": ["eliud_core", "eliud_pkg_membership"]
}