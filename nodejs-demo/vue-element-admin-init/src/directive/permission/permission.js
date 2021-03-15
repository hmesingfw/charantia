import store from '@/store';

export default {
    inserted(el, binding) {
        const { value } = binding;

        const roles = store.getters && store.getters.roles;

        if (value && value.length > 0) {
            const hasPermission = roles.includes(value);

            if (!hasPermission) {
                el.parentNode && el.parentNode.removeChild(el);
            }
        }
    }
};
