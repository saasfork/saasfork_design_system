## 0.0.4

* Added layout system:
  * New `SFDefaultLayout` component with builder pattern for flexible app structures
  * `SFLayoutBuilder` to easily define headers, drawers, content and footers
  * Added `NotificationWrapper` integration in layouts for system-wide notifications
  * Improved documentation with layout usage examples

* Added navigation components:
  * New `SFNavBar` component for consistent application headers
  * `SFNavLink` for navigation items with active states
  * Support for responsive navigation behavior
  * Custom theming options for navigation components

## 0.0.3

* Refactored class naming convention:
  * Renamed all design system classes with the 'SF' prefix for better consistency
  * Updated all component names to follow the new naming convention
  * Improved code organization and namespacing

## 0.0.2

* Added responsive system:
  * `ResponsiveGrid` component for automatically adaptive grids
  * `ResponsiveRow` component for creating rows with variable width columns
  * `ResponsiveColumn` component to define relative widths based on screen size
  * `ResponsiveContainer` component to center content with maximum width
  * `ResponsiveContext` extensions to facilitate screen size detection
  * Complete documentation of the responsive system
* Added notification system:
  * Notification service with overlay support
  * Extensions to simplify displaying notifications (success, error, info, warning)
  * Support for customizing notifications and their display duration

## 0.0.1

* Initial version 