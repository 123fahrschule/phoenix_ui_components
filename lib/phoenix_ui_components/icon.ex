defmodule PhoenixUiComponents.Icon do
  use PhoenixUiComponents, :component

  attr :class, :any, default: nil
  attr :icon, :any, required: true
  attr :outlined, :boolean, default: false
  attr :rest, :global

  def icon(%{icon: :overland_lesson_icon} = assigns) do
    ~H"""
    <svg
      class={@class}
      width="24"
      height="24"
      viewBox="0 0 19 16"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      {@rest}
    >
      <path
        fill-rule="evenodd"
        clip-rule="evenodd"
        d="M0.749999 0C0.533329 0 0.35431 0.0706799 0.21301 0.21198C0.0709799 0.35401 0 0.533329 0 0.749999V14.875C0 15.075 0.0709799 15.25 0.21301 15.4C0.35431 15.55 0.533319 15.625 0.749999 15.625C0.966679 15.625 1.14569 15.55 1.28699 15.4C1.42902 15.25 1.5 15.075 1.5 14.875V0.749999C1.5 0.533329 1.42902 0.354 1.28699 0.21198C1.14569 0.0706799 0.966679 0 0.749999 0ZM7.25 3.625C7.46667 3.625 7.646 3.54999 7.78802 3.40002C7.92932 3.25 8 3.07501 8 2.875V0.749999C8 0.533329 7.92932 0.354 7.78802 0.21198C7.64599 0.0706799 7.46667 0 7.25 0C7.03333 0 6.85431 0.0706799 6.71301 0.21198C6.57098 0.35401 6.5 0.533329 6.5 0.749999V2.875C6.5 3.07501 6.57098 3.25 6.71301 3.40002C6.85431 3.54998 7.03332 3.625 7.25 3.625ZM6.5 14.0759H7.6958V14.7472C7.6958 14.9712 7.73053 15.1864 7.7984 15.3888L7.78802 15.4C7.646 15.55 7.46668 15.625 7.25 15.625C7.03332 15.625 6.85431 15.55 6.71301 15.4C6.57098 15.25 6.5 15.075 6.5 14.875V14.0759ZM14.5 2.90759V0.749999C14.5 0.533329 14.4293 0.354 14.288 0.21198C14.146 0.0706799 13.9667 0 13.75 0C13.5333 0 13.354 0.0706799 13.212 0.21198C13.0707 0.35401 13 0.533329 13 0.749999V2.94446C13.237 2.81574 13.5046 2.75 13.7862 2.75C14.0394 2.75 14.2814 2.80322 14.5 2.90759ZM5.3701 13.218H8.69579V14.9148C8.69579 15.1976 8.79488 15.4379 8.99307 15.6356C9.1908 15.8338 9.43106 15.9329 9.71386 15.9329C9.99666 15.9329 10.2369 15.8338 10.4347 15.6356C10.6328 15.4379 10.7319 15.1976 10.7319 14.9148V13.218H12.7681V14.9148C12.7681 15.1976 12.8672 15.4379 13.0653 15.6356C13.2631 15.8338 13.5033 15.9329 13.7861 15.9329C14.0689 15.9329 14.3092 15.8338 14.5069 15.6356C14.7051 15.4379 14.8042 15.1976 14.8042 14.9148V13.218H18.1299C18.3788 13.218 18.5598 13.1106 18.6729 12.8957C18.786 12.6807 18.7747 12.4715 18.6389 12.2678L16.6028 9.14577H16.7385C16.9761 9.14577 17.1514 9.03537 17.2645 8.81456C17.3777 8.5942 17.3607 8.38222 17.2136 8.1786L14.2952 4.00452C14.1707 3.83484 14.0011 3.75 13.7861 3.75C13.5712 3.75 13.4015 3.83484 13.2771 4.00452L11.75 6.21034L10.2229 4.00452C10.0985 3.83484 9.92879 3.75 9.71386 3.75C9.49893 3.75 9.32926 3.83484 9.20483 4.00452L6.28636 8.1786C6.13931 8.38222 6.12234 8.5942 6.23546 8.81456C6.34858 9.03537 6.52391 9.14577 6.76146 9.14577H6.8972L4.86106 12.2678C4.72532 12.4715 4.71401 12.6807 4.82713 12.8957C4.94025 13.1106 5.12124 13.218 5.3701 13.218ZM14.7363 12.2H14.5327L12.5305 9.14577H12.6663C12.9151 9.14577 13.0932 9.03537 13.2004 8.81456C13.3081 8.5942 13.2941 8.38222 13.1583 8.1786L12.3778 7.07569L13.7861 5.07349L15.9241 8.1277H14.7363L17.3833 12.2H15.9241H14.7363ZM7.57591 12.2H6.11668L8.76366 8.1277H7.57591L9.71386 5.07349L11.8518 8.1277H10.6641L13.311 12.2H13.2004H12.5305H12.3778H11.8518H10.6641H8.76366H7.57591Z"
        fill="currentColor"
      />
    </svg>
    """
  end

  def icon(%{icon: :night_lesson_icon} = assigns) do
    ~H"""
    <svg
      class={@class}
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      {@rest}
    >
      <path
        fill-rule="evenodd"
        clip-rule="evenodd"
        d="M4.96002 4.46002C5.09998 4.32001 5.28003 4.25 5.5 4.25C5.71997 4.25 5.90003 4.32001 6.03998 4.46002C6.17999 4.60004 6.25 4.78003 6.25 5V19.13C6.25 19.33 6.17999 19.5 6.03998 19.65C5.90002 19.8 5.71997 19.88 5.5 19.88C5.28003 19.88 5.09997 19.8 4.96002 19.65C4.82001 19.5 4.75 19.33 4.75 19.13V5C4.75 4.78003 4.82001 4.60003 4.96002 4.46002ZM11.46 10.46C11.6 10.32 11.78 10.25 12 10.25H12.04C11.68 10.81 11.42 11.4 11.25 12.03V11C11.25 10.78 11.32 10.6 11.46 10.46ZM11.47 16.46H11.46C11.32 16.6 11.25 16.78 11.25 17V19.13C11.25 19.33 11.32 19.5 11.46 19.65C11.6 19.8 11.78 19.88 12 19.88C12.22 19.88 12.4 19.8 12.54 19.65C12.68 19.5 12.75 19.33 12.75 19.13V18.58C12.26 18.03 11.86 17.41 11.56 16.72C11.52 16.64 11.49 16.55 11.47 16.46V16.46ZM18.5 4.25C18.72 4.25 18.9 4.32001 19.04 4.46002C19.18 4.60004 19.25 4.78003 19.25 5V13.91C19.1501 13.7801 19.0701 13.6502 18.9902 13.5204L18.99 13.52C18.62 12.88 18.38 12.17 18.28 11.41C18.18 10.66 18.25 9.89001 18.48 9.13C18.67 8.53002 18.59 7.97002 18.26 7.54998C18.12 7.36999 17.95 7.23999 17.75 7.15002V5C17.75 4.78003 17.82 4.60003 17.96 4.46002C18.1 4.32001 18.28 4.25 18.5 4.25ZM12 4.25C11.78 4.25 11.6 4.32001 11.46 4.46002C11.32 4.60003 11.25 4.78003 11.25 5V7.13C11.25 7.33001 11.32 7.5 11.46 7.65002C11.6 7.79998 11.78 7.88 12 7.88C12.22 7.88 12.4 7.79998 12.54 7.65002C12.68 7.5 12.75 7.33001 12.75 7.13V5C12.75 4.78003 12.68 4.60004 12.54 4.46002C12.4 4.32001 12.22 4.25 12 4.25ZM19.781 18.7499C19.2523 18.9422 18.6888 19.0384 18.0904 19.0384C16.6266 19.0384 15.4059 18.5494 14.4285 17.5715C13.4506 16.5941 12.9616 15.3734 12.9616 13.9096C12.9616 12.8411 13.2689 11.8687 13.8835 10.9926C14.4977 10.1164 15.2856 9.49666 16.2473 9.13337C16.0229 10.2446 16.0122 11.2811 16.2152 12.2427C16.4182 13.2043 16.7655 14.0645 17.257 14.8231C17.7485 15.5818 18.3469 16.2282 19.0521 16.7625C19.7573 17.2967 20.4839 17.6974 21.2318 17.9645C20.7937 18.2957 20.3101 18.5575 19.781 18.7499ZM15.6786 19.5352C16.421 19.8451 17.225 20 18.0904 20C18.9346 20 19.7306 19.8344 20.4785 19.5031C21.2265 19.1719 21.8729 18.7231 22.4179 18.1568C22.5995 17.9645 22.6557 17.775 22.5865 17.5882C22.5168 17.401 22.3377 17.27 22.0492 17.1952C21.1303 16.9601 20.3183 16.562 19.6131 16.0008C18.9078 15.4401 18.3415 14.7804 17.9141 14.0218C17.4867 13.2631 17.217 12.435 17.1051 11.5375C16.9927 10.64 17.07 9.73707 17.3371 8.82885C17.4226 8.55104 17.404 8.332 17.2814 8.17172C17.1583 8.01145 16.9685 7.96337 16.7121 8.02748C15.291 8.33734 14.1505 9.03977 13.2905 10.1348C12.4302 11.2302 12 12.4885 12 13.9096C12 14.775 12.1549 15.579 12.4648 16.3214C12.7747 17.0642 13.2021 17.7081 13.747 18.253C14.2919 18.7979 14.9358 19.2253 15.6786 19.5352Z"
        fill="currentColor"
      />
    </svg>
    """
  end

  def icon(%{icon: :highway_lesson_icon} = assigns) do
    ~H"""
    <svg
      class={@class}
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      {@rest}
    >
      <path
        fill-rule="evenodd"
        clip-rule="evenodd"
        d="M18.5 19.875C18.2833 19.875 18.104 19.804 17.962 19.662C17.8207 19.5207 17.75 19.3417 17.75 19.125L16.8119 12.5H18.3119L19.25 19.125C19.25 19.3417 19.1793 19.5207 19.038 19.662C18.896 19.804 18.7167 19.875 18.5 19.875ZM18.1704 11.5H19C19 11.7761 19.2239 12 19.5 12H20.5C20.7761 12 21 11.7761 21 11.5H21.25C21.6642 11.5 22 11.1642 22 10.75C22 10.3358 21.6642 10 21.25 10H17.958H16.458H7.54204H6.04204H2.75C2.33578 10 2 10.3358 2 10.75C2 11.1642 2.33579 11.5 2.75 11.5L3 11.5C3 11.7761 3.22386 12 3.5 12H4.5C4.77614 12 5 11.7761 5 11.5H5.82965H7.32965H11.25H12.75H16.6704H18.1704ZM17.8164 9H16.3164L15.75 5C15.75 4.78333 15.8207 4.604 15.962 4.462C16.104 4.32067 16.2833 4.25 16.5 4.25C16.7167 4.25 16.896 4.32067 17.038 4.462C17.1793 4.604 17.25 4.78333 17.25 5L17.8164 9ZM6.18363 9H7.68363L8.25 5C8.25 4.78333 8.179 4.604 8.037 4.462C7.89567 4.32067 7.71667 4.25 7.5 4.25C7.28333 4.25 7.10433 4.32067 6.963 4.462C6.821 4.604 6.75 4.78333 6.75 5L6.18363 9ZM4.75 19.125L5.68805 12.5H7.18805L6.25 19.125C6.25 19.325 6.179 19.5 6.037 19.65C5.89567 19.8 5.71667 19.875 5.5 19.875C5.28333 19.875 5.10433 19.8 4.963 19.65C4.821 19.5 4.75 19.325 4.75 19.125ZM11.25 13.125V12.5H12.75V13.125C12.75 13.325 12.6793 13.5 12.538 13.65C12.396 13.8 12.2167 13.875 12 13.875C11.7833 13.875 11.6043 13.8 11.463 13.65C11.321 13.5 11.25 13.325 11.25 13.125ZM12 7.875C11.7833 7.875 11.6043 7.8 11.463 7.65C11.321 7.5 11.25 7.325 11.25 7.125V5C11.25 4.78333 11.321 4.604 11.463 4.462C11.6043 4.32067 11.7833 4.25 12 4.25C12.2167 4.25 12.396 4.32067 12.538 4.462C12.6793 4.604 12.75 4.78333 12.75 5V7.125C12.75 7.325 12.6793 7.5 12.538 7.65C12.396 7.8 12.2167 7.875 12 7.875ZM12 19.875C11.7833 19.875 11.6043 19.8 11.463 19.65C11.321 19.5 11.25 19.325 11.25 19.125V17C11.25 16.7833 11.321 16.604 11.463 16.462C11.6043 16.3207 11.7833 16.25 12 16.25C12.2167 16.25 12.396 16.3207 12.538 16.462C12.6793 16.604 12.75 16.7833 12.75 17V19.125C12.75 19.325 12.6793 19.5 12.538 19.65C12.396 19.8 12.2167 19.875 12 19.875Z"
        fill="currentColor"
      />
    </svg>
    """
  end

  def icon(%{icon: :sort} = assigns) do
    ~H"""
    <svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 16 16" fill="none">
      <path
        d="M11.1333 5.65C11.3222 5.83889 11.3667 6.05556 11.2667 6.3C11.1667 6.54444 10.9778 6.66667 10.7 6.66667L5.3 6.66667C5.02222 6.66667 4.83333 6.54444 4.73333 6.3C4.63333 6.05556 4.67778 5.83889 4.86667 5.65L7.58333 2.93333C7.63889 2.86667 7.70267 2.81956 7.77467 2.792C7.84711 2.764 7.92222 2.75 8 2.75C8.07778 2.75 8.15267 2.764 8.22467 2.792C8.29711 2.81956 8.36111 2.86667 8.41667 2.93333L11.1333 5.65ZM11.1333 10.35L8.41667 13.0667C8.36111 13.1333 8.29711 13.1804 8.22467 13.208C8.15267 13.236 8.07778 13.25 8 13.25C7.92222 13.25 7.84711 13.236 7.77467 13.208C7.70267 13.1804 7.63889 13.1333 7.58333 13.0667L4.86667 10.35C4.67778 10.1611 4.63333 9.94444 4.73333 9.7C4.83333 9.45556 5.02222 9.33333 5.3 9.33333L10.7 9.33333C10.9778 9.33333 11.1667 9.45556 11.2667 9.7C11.3667 9.94444 11.3222 10.1611 11.1333 10.35Z"
        fill="currentColor"
      />
    </svg>
    """
  end

  def icon(%{icon: :microsoft} = assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="none"
      class={@class}
      {@rest}
    >
      <path
        d="M3.5 3.5V11.6585H11.6205V3.5H3.5ZM12.3415 3.5V11.6585H20.5V3.5H12.3415ZM3.5 12.3795V20.5H11.6205V12.3795H3.5ZM12.3415 12.3795V20.5H20.5V12.3795H12.3415Z"
        fill="white"
      />
    </svg>
    """
  end

  def icon(assigns) do
    ~H"""
    <span class={["icon", get_material_icon_class(assigns), @class]} {@rest}>
      <%= @icon %>
    </span>
    """
  end

  defp get_material_icon_class(%{outlined: true}), do: "material-icons-outlined"
  defp get_material_icon_class(_), do: "material-icons"
end
