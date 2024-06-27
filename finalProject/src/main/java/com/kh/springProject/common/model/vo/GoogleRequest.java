package com.kh.springProject.common.model.vo;

public class GoogleRequest {
    private String clientId;
    private String redirectUri;
    private String clientSecret;
    private String responseType;
    private String scope;
    private String code;
    private String accessType;
    private String grantType;
    private String state;
    private String includeGrantedScopes;
    private String loginHint;
    private String prompt;

    private GoogleRequest(Builder builder) {
        this.clientId = builder.clientId;
        this.redirectUri = builder.redirectUri;
        this.clientSecret = builder.clientSecret;
        this.responseType = builder.responseType;
        this.scope = builder.scope;
        this.code = builder.code;
        this.accessType = builder.accessType;
        this.grantType = builder.grantType;
        this.state = builder.state;
        this.includeGrantedScopes = builder.includeGrantedScopes;
        this.loginHint = builder.loginHint;
        this.prompt = builder.prompt;
    }

    public static class Builder {
        private String clientId;
        private String redirectUri;
        private String clientSecret;
        private String responseType;
        private String scope;
        private String code;
        private String accessType;
        private String grantType;
        private String state;
        private String includeGrantedScopes;
        private String loginHint;
        private String prompt;

        public Builder clientId(String clientId) {
            this.clientId = clientId;
            return this;
        }

        public Builder redirectUri(String redirectUri) {
            this.redirectUri = redirectUri;
            return this;
        }

        public Builder clientSecret(String clientSecret) {
            this.clientSecret = clientSecret;
            return this;
        }

        public Builder responseType(String responseType) {
            this.responseType = responseType;
            return this;
        }

        public Builder scope(String scope) {
            this.scope = scope;
            return this;
        }

        public Builder code(String code) {
            this.code = code;
            return this;
        }

        public Builder accessType(String accessType) {
            this.accessType = accessType;
            return this;
        }

        public Builder grantType(String grantType) {
            this.grantType = grantType;
            return this;
        }

        public Builder state(String state) {
            this.state = state;
            return this;
        }

        public Builder includeGrantedScopes(String includeGrantedScopes) {
            this.includeGrantedScopes = includeGrantedScopes;
            return this;
        }

        public Builder loginHint(String loginHint) {
            this.loginHint = loginHint;
            return this;
        }

        public Builder prompt(String prompt) {
            this.prompt = prompt;
            return this;
        }

        public GoogleRequest build() {
            return new GoogleRequest(this);
        }
    }

    public String getClientId() {
        return clientId;
    }

    public String getRedirectUri() {
        return redirectUri;
    }

    public String getClientSecret() {
        return clientSecret;
    }

    public String getResponseType() {
        return responseType;
    }

    public String getScope() {
        return scope;
    }

    public String getCode() {
        return code;
    }

    public String getAccessType() {
        return accessType;
    }

    public String getGrantType() {
        return grantType;
    }

    public String getState() {
        return state;
    }

    public String getIncludeGrantedScopes() {
        return includeGrantedScopes;
    }

    public String getLoginHint() {
        return loginHint;
    }

    public String getPrompt() {
        return prompt;
    }
}
