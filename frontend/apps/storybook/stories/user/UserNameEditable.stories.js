import { TextInput } from "@uoisfrontend/shared";
import { CheckLg, TrashFill } from "react-bootstrap-icons";
import { action } from '@storybook/addon-actions';
import { withRouter } from 'storybook-addon-react-router-v6';
import { UserNameEditable } from "@uoisfrontend/user";
import { StorageDecorator } from "../StorageDecorator";
import { UserDecorator, UserGet } from "./UserDecorator";
// import { UserNameEditable } from "@uoisfrontend/user/UserNameEditable";

const meta = {
    //👇 component which is all about
    component: UserNameEditable,
    //👇 Tree position where those stories will be placed
    title: "User/UserNameEditable",
    
    //👇 Needed for componets using react-router library
    //   also for components using useDispatch hook
    decorators: [StorageDecorator, withRouter, UserDecorator],

    //👇 Args for the component's play
    argTypes: {
        onChange: {action: "changed"},
    },
    //👇 Enables auto-generated documentation for the component story
    tags: ['autodocs'],

};

export default meta;

/*
 *👇 Render functions are a framework specific feature to allow you control on how the component renders.
 * See https://storybook.js.org/docs/react/api/csf
 * to learn how to use render functions.
 */
export const UserNameEditableStory = {
    name: "Text Input",
    //👇 Initial value for args
    args: {
        
        // onChange: (value) => action("got " + value)
        user: {
            id: "2d9dc5ca-a4a2-11ed-b9df-0242ac120003"
        }
    },
    parameters: {
        reactRouter: {
            routePath: '/ui/users/:userId',
            routeParams: { userId: '2d9dc5ca-a4a2-11ed-b9df-0242ac120003' },
            routeHandle: "Profile",
            searchParams: { tab: 'activityLog' },
            routeState: { fromPage: 'homePage' },
        }
      },
    
    //👇 how the component will be rendered
    render: (args) => {
        console.log("render", args)
        return <UserGet {...args} id={args.user.id} Visualiser={UserNameEditable} />
    },
};