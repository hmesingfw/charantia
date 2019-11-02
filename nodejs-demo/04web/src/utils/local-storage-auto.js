const staticToken = 'token';


export function getToken() {
    return localStorage.getItem(staticToken);
}

export function setToken(token) {
    return localStorage.setItem(staticToken, token)
}

export function clearToken() {
    localStorage.removeItem(staticToken);
}