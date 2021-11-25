import { createSlice, configureStore } from '@reduxjs/toolkit';

export const authSlice = createSlice({
    name: "auth",
    initialState: { loggedInUserAddress: "", loginForm: { email: "", password: "" } },
    reducers: {}
});

//Each item that is sold has it's own address, and the ability to distribute erc20 tokens.
//Each string will be converted to a 32 bytes array using utils.asciiToHex method.
export const sampleHomeItems = [
    {
        address: "0x000065435342412asdassda3",
        title: "Kuerig Coffee", 
        category: 3,
        quantity: 20
    },
    {
        address: "0x00006543ds5342412adassda3",
        title: "Rice Cooker",
        category: 3,
        quantity: 10
    },
    {
        address: "0x000065432adfasdf342412asdassda3",
        title: "Air Fryer",
        category: 3,
        quantity: 30
    },
    {
        address: "0x0000654353424wrew12asdassda3",
        title: "Microwave Oven",
        category: 3,
        quantity: 20
    },
];
const store = configureStore({
    reducer: {
        auth: authSlice.reducer
    }
});

store.subscribe(() => console.log(state.getState()));

export default store;
